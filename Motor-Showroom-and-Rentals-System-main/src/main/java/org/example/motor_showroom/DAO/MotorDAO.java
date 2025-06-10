package org.example.motor_showroom.DAO;

import org.example.motor_showroom.Models.Motor;
import org.example.motor_showroom.Util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MotorDAO {
    public boolean addMotor(Motor motor) {
        String sql = "INSERT INTO motors (name, type, power, price, description, image_path, availability) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, motor.getName());
            stmt.setString(2, motor.getType());
            stmt.setDouble(3, motor.getPower());
            stmt.setDouble(4, motor.getPrice());
            stmt.setString(5, motor.getDescription());
            stmt.setString(6, motor.getImagePath());
            stmt.setBoolean(7, motor.isAvailability());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateMotor(Motor motor) {
        String sql = "UPDATE motors SET name = ?, type = ?, power = ?, price = ?, description = ?, image_path = ?, availability = ? WHERE motorid = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, motor.getName());
            stmt.setString(2, motor.getType());
            stmt.setDouble(3, motor.getPower());
            stmt.setDouble(4, motor.getPrice());
            stmt.setString(5, motor.getDescription());
            stmt.setString(6, motor.getImagePath());
            stmt.setBoolean(7, motor.isAvailability());
            stmt.setInt(8, motor.getMotorId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMotor(int motorId) {
        String sql = "DELETE FROM motors WHERE motorid = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, motorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Motor> getAllMotors() {
        List<Motor> motors = new ArrayList<>();
        String sql = "SELECT * FROM motors";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Motor motor = new Motor();
                motor.setMotorId(rs.getInt("motorid"));
                motor.setName(rs.getString("name"));
                motor.setType(rs.getString("type"));
                motor.setPower(rs.getDouble("power"));
                motor.setPrice(rs.getDouble("price"));
                motor.setDescription(rs.getString("description"));
                motor.setImagePath(rs.getString("image_path"));
                motor.setAvailability(rs.getBoolean("availability"));
                motors.add(motor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motors;
    }

    public Motor getMotorById(int motorId) {
        String sql = "SELECT * FROM motors WHERE motorid = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, motorId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Motor motor = new Motor();
                motor.setMotorId(rs.getInt("motorid"));
                motor.setName(rs.getString("name"));
                motor.setType(rs.getString("type"));
                motor.setPower(rs.getDouble("power"));
                motor.setPrice(rs.getDouble("price"));
                motor.setDescription(rs.getString("description"));
                motor.setImagePath(rs.getString("image_path"));
                motor.setAvailability(rs.getBoolean("availability"));
                return motor;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Motor> getAvailableMotors() {
        List<Motor> motors = new ArrayList<>();
        String sql = "SELECT * FROM motors WHERE availability = TRUE";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Motor motor = new Motor();
                motor.setMotorId(rs.getInt("motorid"));
                motor.setName(rs.getString("name"));
                motor.setType(rs.getString("type"));
                motor.setPower(rs.getDouble("power"));
                motor.setPrice(rs.getDouble("price"));
                motor.setDescription(rs.getString("description"));
                motor.setImagePath(rs.getString("image_path"));
                motor.setAvailability(rs.getBoolean("availability"));
                motors.add(motor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motors;
    }
    public boolean toggleMotorAvailability(int motorId) {
        String sql = "UPDATE motors SET availability = NOT availability WHERE motorid = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, motorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Motor> searchMotors(String query) {
        List<Motor> motors = new ArrayList<>();
        String sql = "SELECT * FROM motors WHERE name LIKE ? OR description LIKE ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Motor motor = new Motor();
                motor.setMotorId(rs.getInt("motorid"));
                motor.setName(rs.getString("name"));
                motor.setType(rs.getString("type"));
                motor.setPower(rs.getDouble("power"));
                motor.setPrice(rs.getDouble("price"));
                motor.setDescription(rs.getString("description"));
                motor.setImagePath(rs.getString("image_path"));
                motor.setAvailability(rs.getBoolean("availability"));
                motors.add(motor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motors;
    }
}
