package control;

import dao.UserDAO;
import entity.NguoiDung; // Quan trọng: Phải import đúng package của bạn
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Thêm để dùng Session
import java.io.IOException;

@WebServlet(name = "SaveOrderControl", urlPatterns = {"/saveOrder"})
public class SaveOrderControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Đảm bảo nhận được tiếng Việt (tên món, ghi chú) từ AJAX gửi qua
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 2. Kiểm tra Session để biết ai đang đặt hàng
        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        // Nếu chưa đăng nhập (acc là null), không cho lưu đơn
        if (acc == null) {
            response.getWriter().write("fail: user_not_logged_in");
            return;
        }

        // 3. Lấy dữ liệu giỏ hàng và chuỗi tóm tắt (summary) từ AJAX
        String jsonCart = request.getParameter("dataCart");
        String summary = request.getParameter("summary");

        // 4. Lấy ID thật của cư dân đang đăng nhập
        int accountId = acc.getMaNguoiDung();

        if (jsonCart != null && !jsonCart.isEmpty()) {
            UserDAO dao = new UserDAO();

            // 5. Gọi hàm lưu đơn và cập nhật tích lũy/danh hiệu
            boolean isSuccess = dao.insertFullOrder(accountId, jsonCart, summary);

            if (isSuccess) {
                // Sau khi lưu thành công, hãy cập nhật lại đối tượng user trong session
                // để menu.jsp hiển thị ngay Danh hiệu/Tiền mới mà không cần đăng nhập lại
                NguoiDung updatedAcc = dao.login(acc.getTenDangNhap(), acc.getMatKhau());
                session.setAttribute("user", updatedAcc);

                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail");
            }
        }
    }
}