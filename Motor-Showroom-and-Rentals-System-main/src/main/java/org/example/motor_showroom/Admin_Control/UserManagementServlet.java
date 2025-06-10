package org.example.motor_showroom.Admin_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.motor_showroom.DAO.UserDAO;
import org.example.motor_showroom.Models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<User> users = userDao.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/Admin dashboard/manage-users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=Error+loading+users");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateRole".equals(action)) {
                handleUpdateRole(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteUser(request, response);
            } else {
                response.sendRedirect("users?error=Invalid+action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users?error=Error+processing+request");
        }
    }

    private void handleUpdateRole(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String newRole = request.getParameter("role");

        if (userDao.updateUserRole(userId, newRole)) {
            response.sendRedirect("users?success=User+role+updated+successfully");
        } else {
            response.sendRedirect("users?error=Failed+to+update+user+role");
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        if (userDao.deleteUser(userId)) {
            response.sendRedirect("users?success=User+deleted+successfully");
        } else {
            response.sendRedirect("users?error=Failed+to+delete+user");
        }
    }
}