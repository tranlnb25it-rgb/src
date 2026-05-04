package control;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RedeemControl", urlPatterns = {"/redeem-rewards"})
public class RedeemControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        request.setAttribute("listRewards", dao.getAllRewards());
        request.getRequestDispatcher("redeem.jsp").forward(request, response);
    }
}