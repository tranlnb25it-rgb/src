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

@WebServlet(name = "UseOfferControl", urlPatterns = {"/use-offer"})
public class UseOfferControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy mã khuyến mãi từ URL (ví dụ: ?code=CHAOXUAN)
        String code = request.getParameter("code");

        // 2. Lấy thông tin người dùng từ Session
        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        if (acc != null && code != null) {
            // 3. Gọi DAO để lưu vào Database
            KhuyenMaiDAO dao = new KhuyenMaiDAO();
            dao.saveUsedOffer(acc.getMaNguoiDung(), code);
        }

        // 4. Quay lại trang khuyến mãi (lúc này Servlet SpecialOffersControl sẽ chạy lại,
        // lấy danh sách mới và ẩn mã đã dùng đi)
        response.sendRedirect("special-offers");

        System.out.println("Đã nhấn nút sử dụng mã: " + code);
    }

}