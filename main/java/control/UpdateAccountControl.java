package control;

import dao.UserDAO;
import entity.NguoiDung;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UpdateAccountControl", urlPatterns = {"/update-account"})
public class UpdateAccountControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        // 1. Lấy dữ liệu từ Form
        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String oldPassInput = request.getParameter("oldPass"); // Mật khẩu cư dân vừa nhập
        String newPass = request.getParameter("newPass");

        // 2. KIỂM TRA MẬT KHẨU CŨ
        // So sánh mật khẩu nhập vào với mật khẩu trong Session
        if (!acc.getMatKhau().trim().equals(oldPassInput.trim())) {
            request.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
            request.getRequestDispatcher("account.jsp").forward(request, response);
            return;
        }

        // 3. Xử lý mật khẩu mới
        // Nếu cư dân để trống ô mật khẩu mới, thì giữ nguyên mật khẩu cũ
        if (newPass == null || newPass.isEmpty()) {
            newPass = acc.getMatKhau();
        }

        // 4. Gọi DAO cập nhật Database
        UserDAO dao = new UserDAO();
        if (dao.updateAccount(acc.getMaNguoiDung(), name, phone, newPass)) {
            // Cập nhật lại Session để dữ liệu luôn mới nhất
            acc.setHoTen(name);
            acc.setSoDienThoai(phone);
            acc.setMatKhau(newPass);
            session.setAttribute("user", acc);

            request.setAttribute("mess", "Cập nhật thông tin thành công ✨");
            request.getRequestDispatcher("account.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            request.getRequestDispatcher("account.jsp").forward(request, response);
        }
    }
}