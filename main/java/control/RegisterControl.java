package control;

import dao.UserDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date; // Nhớ có import này để dùng cho ngày sinh

@WebServlet(name = "RegisterControl", urlPatterns = {"/register"})
public class RegisterControl extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Thiết lập tiếng Việt (Cần thiết để không bị lỗi font khi cư dân nhập tên)
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 2. Lấy dữ liệu từ Form (Đúng theo các name="xxx" trong file register.jsp)
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob"); // Ngày sinh
        String phone = request.getParameter("phone");
        String email = request.getParameter("email"); // Email

        UserDAO dao = new UserDAO();

        try {
            // 3. Chuyển đổi String dob sang java.sql.Date
            Date dateOfBirth = null;
            if (dob != null && !dob.isEmpty()) {
                dateOfBirth = Date.valueOf(dob);
            }

            // 4. Gọi DAO để lưu vào Database
            // Lưu ý: Thứ tự truyền vào phải KHỚP với hàm register trong UserDAO của Trân
            dao.register(user, pass, name, dateOfBirth, phone);

            // 5. Thành công -> Chuyển hướng sang Login
            response.sendRedirect("login");

        } catch (Exception e) {
            // 6. Thất bại -> Quay lại trang đăng ký kèm thông báo
            e.printStackTrace();
            request.setAttribute("mess", "Tên đăng nhập đã tồn tại hoặc có lỗi xảy ra!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}