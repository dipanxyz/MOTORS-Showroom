package org.example.motor_showroom.Admin_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.motor_showroom.DAO.MotorDAO;
import org.example.motor_showroom.DAO.OrderDAO;
import org.example.motor_showroom.DAO.UserDAO;
import org.example.motor_showroom.Models.User;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private MotorDAO motorDao;
    private OrderDAO orderDao;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        motorDao = new MotorDAO();
        orderDao = new OrderDAO();
        userDao = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Customer dashboard/customer.jsp");
            return;
        }

        try {
            request.setAttribute("totalMotors", motorDao.getAllMotors().size());
            request.setAttribute("totalOrders", orderDao.getAllOrders().size());
            request.setAttribute("totalUsers", userDao.getAllUsers().size());
            request.setAttribute("recentOrders", orderDao.getRecentOrders(5));
            request.getRequestDispatcher("/Admin dashboard/admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server Error");
        }
    }
}