package org.example.motor_showroom.DAO;

import org.example.motor_showroom.Models.Order;
import org.example.motor_showroom.Util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.example.motor_showroom.Util.DatabaseUtil.getConnection;

public class OrderDAO {

    // Create new order
    public boolean createOrder(Order order) {
        String sql = "INSERT INTO orders (userid, motorid, order_type, rent_duration, "
                + "total_amount, delivery_address, payment_method, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, order.getUserId());
            stmt.setInt(2, order.getMotorId());
            stmt.setString(3, order.getOrderType());
            stmt.setObject(4, order.getRentDuration(), Types.INTEGER);
            stmt.setDouble(5, order.getTotalAmount());
            stmt.setString(6, order.getDeliveryAddress());
            stmt.setString(7, order.getPaymentMethod());
            stmt.setString(8, order.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, m.name as motor_name FROM orders o " +
                "JOIN motors m ON o.motorid = m.motorid " +
                "WHERE o.userid = ? ORDER BY o.order_date DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderid"));
                order.setUserId(rs.getInt("userid"));
                order.setMotorId(rs.getInt("motorid"));
                order.setOrderType(rs.getString("order_type"));
                order.setRentDuration(rs.getInt("rent_duration"));
                if (rs.wasNull()) {
                    order.setRentDuration(null);
                }
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setMotorName(rs.getString("motor_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching orders for user " + userId);
            e.printStackTrace();
        }
        return orders;
    }


    // Get all orders (admin view)
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, m.name as motor_name, u.username as customer_name " +
                "FROM orders o " +
                "JOIN motors m ON o.motorid = m.motorid " +
                "JOIN users u ON o.userid = u.userid " +
                "ORDER BY o.order_date DESC";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                orders.add(mapOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get recent orders with limit
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, m.name as motor_name FROM orders o "
                + "JOIN motors m ON o.motorid = m.motorid "
                + "ORDER BY o.order_date DESC LIMIT ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE orderid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get single order by ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, m.name as motor_name FROM orders o "
                + "JOIN motors m ON o.motorid = m.motorid WHERE o.orderid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapOrderFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public Integer getLatestOrderId(int userId) {
        String sql = "SELECT orderid FROM orders WHERE userid = ? ORDER BY order_date DESC LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("orderid");
            }
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    // Delete order
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE orderid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map ResultSet to Order object
    private Order mapOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("orderid"));
        order.setUserId(rs.getInt("userid"));
        order.setMotorId(rs.getInt("motorid"));
        order.setOrderType(rs.getString("order_type"));
        order.setRentDuration(rs.getInt("rent_duration"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setStatus(rs.getString("status"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setMotorName(rs.getString("motor_name"));
        order.setCustomerName(rs.getString("customer_name")); // Add this line
        return order;
    }
}