package org.example.motor_showroom.Auth_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.motor_showroom.DAO.UserDAO;
import org.example.motor_showroom.Models.User;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Validate inputs
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDao.usernameExists(username)) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDao.emailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        // Validate role selection
        if (!"Admin".equals(role) && !"Customer".equals(role)) {
            request.setAttribute("error", "Please select a valid role");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User newUser = new User(username, email, password, address, role);

        if (userDao.registerUser(newUser)) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Registration+successful");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }
}