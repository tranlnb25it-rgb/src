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

@WebServlet(name = "RedeemActionControl", urlPatterns = {"/redeem-action"})
public class RedeemActionControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra xem cư dân đã đăng nhập chưa
        HttpSession session = request.getSession();
        NguoiDung acc = (NguoiDung) session.getAttribute("user");

        if (acc == null) {
            response.sendRedirect("login"); // Nếu chưa thì mời đi đăng nhập đã
            return;
        }

        try {
            // 2. Lấy mã quà và số điểm cần đổi từ trang JSP gửi qua
            int maQua = Integer.parseInt(request.getParameter("maQua"));
            int diemDoi = Integer.parseInt(request.getParameter("diem"));

            // 3. Gọi DAO để thực hiện "phép màu" trừ điểm và trừ kho quà
            UserDAO dao = new UserDAO();
            boolean success = dao.redeemReward(acc.getMaNguoiDung(), maQua, diemDoi);

            if (success) {
                // QUAN TRỌNG: Cập nhật lại số điểm mới vào Session để trên Navbar thay đổi ngay
                acc.setDiemTichLuy(acc.getDiemTichLuy() - diemDoi);
                session.setAttribute("user", acc);

                // Gửi thông báo chúc mừng
                request.setAttribute("mess", "✨ Chúc mừng cư dân " + acc.getHoTen() + " đã đổi quà thành công! Check kho đồ ngay nhé.");
            } else {
                request.setAttribute("error", "Ôi, đổi quà không thành công. Có thể bạn không đủ điểm hoặc quà đã hết.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Hệ thống gặp chút trục trặc, thử lại sau nhé!");
        }

        // 4. Đẩy cư dân quay lại trang danh sách quà tặng để xem số điểm mới
        request.getRequestDispatcher("redeem-rewards").forward(request, response);
    }
}