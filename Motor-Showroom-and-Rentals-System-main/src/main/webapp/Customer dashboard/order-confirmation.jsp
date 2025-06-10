<%@page import="org.example.motor_showroom.Models.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #343a40;
            padding: 15px;
            color: white;
        }
        .navbar a {
            color: white;
            margin-right: 20px;
            text-decoration: none;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .success-icon {
            font-size: 72px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .order-details {
            text-align: left;
            margin: 30px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    Order order = (Order) request.getAttribute("order");
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/customer/dashboard");
        return;
    }
%>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/customer/dashboard">Home</a>
    <a href="${pageContext.request.contextPath}/customer/order">My Orders</a>
    <a href="${pageContext.request.contextPath}/about-us.jsp">About Us</a>
    <a href="${pageContext.request.contextPath}/contact-us.jsp">Contact Us</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>

<div class="container">
    <div class="success-icon">✓</div>
    <h1>Order Confirmed!</h1>
    <p>Thank you for your order. Your order ID is: <strong><%= order.getOrderId() %></strong></p>

    <div class="order-details">
        <h3>Order Details</h3>
        <p><strong>Motor:</strong> <%= order.getMotorName() %></p>
        <p><strong>Order Type:</strong> <%= order.getOrderType() %></p>
        <% if (order.getRentDuration() != null) { %>
        <p><strong>Rental Duration:</strong> <%= order.getRentDuration() %> days</p>
        <% } %>
        <p><strong>Total Amount:</strong> $<%= String.format("%.2f", order.getTotalAmount()) %></p>
        <p><strong>Delivery Address:</strong> <%= order.getDeliveryAddress() %></p>
        <p><strong>Payment Method:</strong> <%= order.getPaymentMethod() %></p>
        <p><strong>Status:</strong> <%= order.getStatus() %></p>
        <p><strong>Order Date:</strong> <%= order.getOrderDate() %></p>
    </div>

    <a href="${pageContext.request.contextPath}/customer/orders" class="btn">View My Orders</a>
</div>
</body>
</html>