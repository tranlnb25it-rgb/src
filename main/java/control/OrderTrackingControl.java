package control;

import dao.UserDAO;
import entity.DonHangCustom;
import entity.NguoiDung;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderTrackingControl", urlPatterns = {"/order-tracking"})
public class OrderTrackingControl extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy Session kiểm tra đăng nhập
        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        // 2. Lấy lịch sử đơn hàng
        UserDAO dao = new UserDAO();
        List<DonHangCustom> list = dao.getOrderHistory(acc.getMaNguoiDung());

        // 3. Gửi dữ liệu sang trang JSP
        request.setAttribute("listOrders", list);
        request.getRequestDispatcher("order_tracking.jsp").forward(request, response);
    }
}