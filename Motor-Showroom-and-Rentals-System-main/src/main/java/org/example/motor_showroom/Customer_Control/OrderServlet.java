package org.example.motor_showroom.Customer_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.motor_showroom.DAO.MotorDAO;
import org.example.motor_showroom.DAO.OrderDAO;
import org.example.motor_showroom.Models.Motor;
import org.example.motor_showroom.Models.Order;
import org.example.motor_showroom.Models.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

@WebServlet("/customer/order")
public class OrderServlet extends HttpServlet {
    private MotorDAO motorDao;
    private OrderDAO orderDao;

    @Override
    public void init() throws ServletException {
        super.init();
        motorDao = new MotorDAO();
        orderDao = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String motorIdParam = request.getParameter("motorId");

        // If motorId parameter exists, show order form
        if (motorIdParam != null) {
            try {
                int motorId = Integer.parseInt(motorIdParam);
                Motor motor = motorDao.getMotorById(motorId);
                if (motor == null || !motor.isAvailability()) {
                    response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Motor+not+available");
                    return;
                }
                request.setAttribute("motor", motor);
                request.getRequestDispatcher("/Customer dashboard/order-motor.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Invalid+motor+ID");
            }
        }
        // Otherwise show orders list
        else {
            User user = (User) session.getAttribute("user");
            try {
                List<Order> orders = orderDao.getOrdersByUserId(user.getUserId());
                if (orders == null) {
                    request.setAttribute("error", "Failed to load orders. Please try again.");
                } else {
                    request.setAttribute("orders", orders);
                }
                request.getRequestDispatcher("/Customer dashboard/my-orders.jsp").forward(request, response);
            } catch (Exception e) {
                System.err.println("Error loading orders for user " + user.getUserId());
                e.printStackTrace();
                request.setAttribute("error", "Error loading orders: " + e.getMessage());
                request.getRequestDispatcher("/Customer dashboard/my-orders.jsp").forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String motorIdParam = request.getParameter("motorId");
        String orderType = request.getParameter("orderType");

        if (motorIdParam == null || orderType == null) {
            response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Invalid+request");
            return;
        }

        try {
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setMotorId(Integer.parseInt(motorIdParam));
            order.setOrderType(orderType);

            // Validate rent duration for rental orders
            if ("Rent".equals(orderType)) {
                String rentDurationParam = request.getParameter("rentDuration");
                if (rentDurationParam == null || rentDurationParam.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/customer/order?motorId=" + motorIdParam + "&error=Please+enter+rental+duration");
                    return;
                }
                int rentDuration = Integer.parseInt(rentDurationParam);
                if (rentDuration < 1) {
                    response.sendRedirect(request.getContextPath() + "/customer/order?motorId=" + motorIdParam + "&error=Rental+duration+must+be+at+least+1+day");
                    return;
                }
                order.setRentDuration(rentDuration);
            }

            Motor motor = motorDao.getMotorById(order.getMotorId());
            if (motor == null || !motor.isAvailability()) {
                response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Motor+not+available");
                return;
            }

            // Set motor name in the order
            order.setMotorName(motor.getName());

            // Calculate total
            double total = calculateTotal(motor, order.getRentDuration());
            order.setTotalAmount(total);
            order.setDeliveryAddress(request.getParameter("deliveryAddress"));
            order.setPaymentMethod(request.getParameter("paymentMethod"));
            order.setStatus("Pending");
            order.setOrderDate(Timestamp.from(Instant.now()));

            if (orderDao.createOrder(order)) {
                System.out.println("Order created successfully, redirecting to confirmation page");
                response.sendRedirect(request.getContextPath() + "/customer/order/confirmation?orderId=" + orderDao.getLatestOrderId(user.getUserId()));
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/order?motorId=" + motorIdParam + "&error=Failed+to+place+order");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/order?motorId=" + motorIdParam + "&error=Invalid+input");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/dashboard?error=Unexpected+error");
        }
    }

    private double calculateTotal(Motor motor, Integer rentDuration) {
        if (rentDuration == null) {
            return motor.getPrice() + 49.99; // Base price + shipping
        }
        return (motor.getPrice() * 0.1 * rentDuration) + 49.99; // 10% of price per day + shipping
    }
}