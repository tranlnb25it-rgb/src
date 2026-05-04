package control;

import dao.UserDAO;
import model.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MenuControl", urlPatterns = {"/menu"})
public class MenuControl extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Gọi DAO để lấy danh sách 200 món
        UserDAO dao = new UserDAO();
        List<Product> list = dao.getAllProduct();

        // 2. Đẩy danh sách này lên vùng nhớ của Request với tên gọi "listP"
        request.setAttribute("listP", list);

        // 3. Mở cánh cửa dẫn sang trang menu.jsp (để hiển thị)
        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}