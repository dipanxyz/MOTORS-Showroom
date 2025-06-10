package org.example.motor_showroom.Customer_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.motor_showroom.DAO.OrderDAO;
import org.example.motor_showroom.Models.Order;
import org.example.motor_showroom.Models.User;

import java.io.IOException;

@WebServlet("/customer/order/confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    private OrderDAO orderDao;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDao = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Invalid+order");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            User user = (User) session.getAttribute("user");
            Order order = orderDao.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Order+not+found");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/Customer dashboard/order-confirmation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Invalid+order");
        }
    }
}