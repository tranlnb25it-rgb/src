package control;

import dao.KhuyenMaiDAO;
import entity.NguoiDung;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SpecialOffersControl", urlPatterns = {"/special-offers"})
public class SpecialOffersControl extends HttpServlet {
    // Trong file SpecialOffersControl.java
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        if (acc != null) {
            KhuyenMaiDAO dao = new KhuyenMaiDAO();
            // Lấy danh sách các mã mà cư dân này ĐÃ dùng
            List<String> usedOffers = dao.getUsedOffers(acc.getMaNguoiDung());
            // Gửi danh sách này sang JSP để so sánh
            request.setAttribute("usedOffers", usedOffers);
        }

        request.getRequestDispatcher("offers.jsp").forward(request, response);
    }
}