package org.example.motor_showroom.Models;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int userId;
    private int motorId;
    private String orderType;
    private Integer rentDuration;
    private double totalAmount;
    private String deliveryAddress;
    private String paymentMethod;
    private String status;
    private Timestamp orderDate;
    private String motorName;
    private String customerName;

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getMotorId() { return motorId; }
    public void setMotorId(int motorId) { this.motorId = motorId; }
    public String getOrderType() { return orderType; }
    public void setOrderType(String orderType) { this.orderType = orderType; }
    public Integer getRentDuration() { return rentDuration; }
    public void setRentDuration(Integer rentDuration) { this.rentDuration = rentDuration; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    public String getMotorName() { return motorName; } // New getter
    public void setMotorName(String motorName) { this.motorName = motorName; }
    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
}