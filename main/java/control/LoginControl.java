package control;

import dao.UserDAO;
import entity.NguoiDung;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginControl", urlPatterns = {"/login"})
public class LoginControl extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy user và pass từ form đăng nhập
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        UserDAO dao = new UserDAO();
        // 2. Kiểm tra trong Database xem có ông này không
        NguoiDung acc = dao.login(user, pass);

        if (acc != null) {
            // 3. Nếu ĐÚNG: Lưu thông tin vào Session để các trang khác (menu.jsp) dùng chung
            HttpSession session = request.getSession();
            session.setAttribute("user", acc);

            // Dẫn khách vào trang Menu
            response.sendRedirect("menu");
        } else {
            // 4. Nếu SAI: Đẩy về trang login kèm lời báo lỗi
            request.setAttribute("mess", "Sai tài khoản hoặc mật khẩu rồi cư dân ơi!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cho phép truy cập link /login bằng cả phương thức GET
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

}