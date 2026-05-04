package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutControl", urlPatterns = {"/logout"})
public class LogoutControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy session hiện tại
        HttpSession session = request.getSession();

        // 2. Xóa bỏ đối tượng "user" hoặc hủy toàn bộ session
        session.removeAttribute("user");
        // Hoặc dùng session.invalidate(); để xóa sạch mọi thứ (giỏ hàng, điểm...)

        // 3. Đẩy cư dân về trang chủ hoặc trang login
        response.sendRedirect("index.jsp");
    }
}