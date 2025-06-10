package org.example.motor_showroom.Customer_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.motor_showroom.DAO.MotorDAO;
import org.example.motor_showroom.Models.Motor;
import org.example.motor_showroom.Models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer/dashboard")
public class CustomerDashboardServlet extends HttpServlet {
    private MotorDAO motorDao;

    @Override
    public void init() throws ServletException {
        super.init();
        motorDao = new MotorDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Motor> availableMotors = motorDao.getAvailableMotors();

        // Debug output
        System.out.println("Number of available motors: " + availableMotors.size());
        for (Motor motor : availableMotors) {
            System.out.println("Motor: " + motor.getName() + ", Image Path: " + motor.getImagePath());
        }

        request.setAttribute("availableMotors", availableMotors);
        request.getRequestDispatcher("/Customer dashboard/customer.jsp").forward(request, response);
    }
}