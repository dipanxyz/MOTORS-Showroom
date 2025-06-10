package org.example.motor_showroom.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/motor_showroom?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            throw new RuntimeException("Failed to load JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Properties props = new Properties();
            props.setProperty("user", USER);
            props.setProperty("password", PASSWORD);
            props.setProperty("useSSL", "false");
            props.setProperty("autoReconnect", "true");
            props.setProperty("characterEncoding", "UTF-8");
            props.setProperty("useUnicode", "true");

            return DriverManager.getConnection(URL, props);
        } catch (SQLException e) {
            System.err.println("Database connection failed!");
            System.err.println("URL: " + URL);
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }
}