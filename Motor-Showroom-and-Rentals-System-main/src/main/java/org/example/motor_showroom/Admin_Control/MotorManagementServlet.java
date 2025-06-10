package org.example.motor_showroom.Admin_Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.motor_showroom.DAO.MotorDAO;
import org.example.motor_showroom.Models.Motor;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@WebServlet("/admin/motors")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB
        maxRequestSize = 1024 * 1024 * 5 * 5 // 25MB
)
public class MotorManagementServlet extends HttpServlet {
    private MotorDAO motorDao;
    private String UPLOAD_DIRECTORY;

    @Override
    public void init() throws ServletException {
        super.init();
        motorDao = new MotorDAO();
        // Initialize upload directory path
        UPLOAD_DIRECTORY = getServletContext().getRealPath("/") + "uploads";
        // Create directory if it doesn't exist
        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                throw new ServletException("Failed to create upload directory");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int motorId = Integer.parseInt(request.getParameter("id"));
            Motor motor = motorDao.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("motors?error=Motor+not+found");
                return;
            }
            request.setAttribute("motor", motor);
            request.getRequestDispatcher("/Admin dashboard/edit-motor.jsp").forward(request, response);
        } else {
            List<Motor> allMotors = motorDao.getAllMotors();
            request.setAttribute("allMotors", allMotors);
            request.getRequestDispatcher("/Admin dashboard/manage-motors.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                handleAddMotor(request, response);
            } else if ("update".equals(action)) {
                handleUpdateMotor(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteMotor(request, response);
            } else if ("toggle".equals(action)) {
                handleToggleAvailability(request, response);
            } else {
                response.sendRedirect("motors?error=Invalid+action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("motors?error=Error+processing+request");
        }
    }

    private void handleAddMotor(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Motor motor = new Motor();
        motor.setName(request.getParameter("name"));
        motor.setType(request.getParameter("type"));
        motor.setPower(Double.parseDouble(request.getParameter("power")));
        motor.setPrice(Double.parseDouble(request.getParameter("price")));
        motor.setDescription(request.getParameter("description"));

        Part filePart = request.getPart("image");
        String fileName = getValidFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            response.sendRedirect("motors?error=Invalid+file");
            return;
        }

        String filePath = UPLOAD_DIRECTORY + File.separator + fileName;

        // More robust file saving
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Store relative path in database
        motor.setImagePath("uploads/" + fileName);
        motor.setAvailability(true);

        if (motorDao.addMotor(motor)) {
            response.sendRedirect("motors?success=Motor+added+successfully");
        } else {
            // Clean up if database operation fails
            new File(filePath).delete();
            response.sendRedirect("motors?error=Failed+to+add+motor");
        }
    }

    private void handleUpdateMotor(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Motor motor = new Motor();
        motor.setMotorId(Integer.parseInt(request.getParameter("motorId")));
        motor.setName(request.getParameter("name"));
        motor.setType(request.getParameter("type"));
        motor.setPower(Double.parseDouble(request.getParameter("power")));
        motor.setPrice(Double.parseDouble(request.getParameter("price")));
        motor.setDescription(request.getParameter("description"));

        Part filePart = request.getPart("image");
        if (filePart.getSize() > 0) {
            String fileName = getValidFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                response.sendRedirect("motors?error=Invalid+file");
                return;
            }

            String filePath = UPLOAD_DIRECTORY + File.separator + fileName;

            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            motor.setImagePath("uploads/" + fileName);
        }

        if (motorDao.updateMotor(motor)) {
            response.sendRedirect("motors?success=Motor+updated+successfully");
        } else {
            response.sendRedirect("motors?error=Failed+to+update+motor");
        }
    }

    private void handleDeleteMotor(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int motorId = Integer.parseInt(request.getParameter("motorId"));

        try {
            // 1. First get the motor to find its image path
            Motor motor = motorDao.getMotorById(motorId);

            if (motor == null) {
                response.sendRedirect("motors?error=Motor+not+found");
                return;
            }

            // 2. Delete the associated image file if it exists
            if (motor.getImagePath() != null && !motor.getImagePath().isEmpty()) {
                String imagePath = getServletContext().getRealPath("/") + motor.getImagePath();
                Path fileToDelete = Paths.get(imagePath);

                try {
                    Files.deleteIfExists(fileToDelete);
                    System.out.println("Deleted image file: " + imagePath);
                } catch (IOException e) {
                    System.err.println("Failed to delete image file: " + e.getMessage());
                    // Continue with DB deletion even if file deletion fails
                }
            }

            // 3. Delete from database
            if (motorDao.deleteMotor(motorId)) {
                response.sendRedirect("motors?success=Motor+deleted+successfully");
            } else {
                response.sendRedirect("motors?error=Failed+to+delete+motor");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("motors?error=Error+deleting+motor");
        }
    }

    private void handleToggleAvailability(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int motorId = Integer.parseInt(request.getParameter("id"));
        if (motorDao.toggleMotorAvailability(motorId)) {
            response.sendRedirect("motors?success=Availability+updated+successfully");
        } else {
            response.sendRedirect("motors?error=Failed+to+update+availability");
        }
    }

    // Helper method to get valid filename
    private String getValidFileName(Part part) {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null || submittedFileName.isEmpty()) {
            return null;
        }

        // Sanitize filename
        String fileName = new File(submittedFileName).getName();
        fileName = System.currentTimeMillis() + "_" + fileName.replaceAll("[^a-zA-Z0-9.-]", "_");

        // Validate extension
        if (!fileName.toLowerCase().matches(".*\\.(jpg|jpeg|png|gif)$")) {
            return null;
        }

        return fileName;
    }
}