package org.example.motor_showroom.Admin_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.motor_showroom.DAO.OrderDAO;
import org.example.motor_showroom.Models.Order;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class OrderManagementServlet extends HttpServlet {
    private OrderDAO orderDao;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDao = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Order> orders = orderDao.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/Admin dashboard/manage-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=Error+loading+orders");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteOrder(request, response);
            } else {
                response.sendRedirect("orders?error=Invalid+action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orders?error=Error+processing+request");
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        if (orderDao.updateOrderStatus(orderId, newStatus)) {
            response.sendRedirect("orders?success=Order+status+updated+successfully");
        } else {
            response.sendRedirect("orders?error=Failed+to+update+order+status");
        }
    }

    private void handleDeleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        if (orderDao.deleteOrder(orderId)) {
            response.sendRedirect("orders?success=Order+deleted+successfully");
        } else {
            response.sendRedirect("orders?error=Failed+to+delete+order");
        }
    }
}