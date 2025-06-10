<%@page import="java.util.List"%>
<%@page import="org.example.motor_showroom.Models.Order"%>
<%@page import="org.example.motor_showroom.Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --sidebar-bg: #343a40;
            --sidebar-text: #ffffff;
            --primary-bg: #f1f3f5;
            --card-bg: #ffffff;
            --accent: #007bff;
            --danger: #dc3545;
            --pending: #ffc107;
            --completed: #28a745;
            --cancelled: #dc3545;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--primary-bg);
            color: #333;
        }

        .navbar {
            background-color: var(--sidebar-bg);
            padding: 15px;
            color: white;
            margin-bottom: 20px;
        }

        .navbar a {
            color: white;
            margin-right: 20px;
            text-decoration: none;
        }

        .navbar a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0;
            font-size: 1.8rem;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            color: white;
            display: inline-block;
            min-width: 80px;
            text-align: center;
        }

        .status-pending {
            background-color: var(--pending);
        }

        .status-completed {
            background-color: var(--completed);
        }

        .status-cancelled {
            background-color: var(--cancelled);
        }

        .btn {
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            font-size: 0.9rem;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background-color: var(--accent);
            color: white;
        }

        .btn-primary:hover {
            background-color: #0069d9;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-size: 1.1rem;
        }

        .order-id {
            font-weight: 600;
            color: var(--accent);
        }

        .motor-name {
            font-weight: 500;
        }

        .order-date {
            white-space: nowrap;
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/customer/dashboard">Home</a>
    <a href="${pageContext.request.contextPath}/customer/order" class="active">My Orders</a>
    <a href="${pageContext.request.contextPath}/Customer dashboard/about-us.jsp">About Us</a>
    <a href="${pageContext.request.contextPath}/Customer dashboard/contact-us.jsp">Contact Us</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>

<div class="container">
    <div class="header">
        <h1>My Orders</h1>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <table>
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Motor</th>
            <th>Type</th>
            <th>Total</th>
            <th>Status</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
                    if (order.getUserId() == user.getUserId()) {
        %>
        <tr>
            <td class="order-id">#<%= order.getOrderId() %></td>
            <td class="motor-name"><%= order.getMotorName() != null ? order.getMotorName() : "Motor ID: " + order.getMotorId() %></td>
            <td><%= order.getOrderType() %></td>
            <td>$<%= String.format("%.2f", order.getTotalAmount()) %></td>
            <td>
                    <span class="status status-<%= order.getStatus().toLowerCase() %>">
                        <%= order.getStatus() %>
                    </span>
            </td>
            <td class="order-date"><%= order.getOrderDate() != null ? order.getOrderDate().toString() : "N/A" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/customer/order/confirmation?orderId=<%= order.getOrderId() %>"
                   class="btn btn-primary">View Details</a>
            </td>
        </tr>
        <%
                }
            }
        } else {
        %>
        <tr>
            <td colspan="7" class="empty-state">You haven't placed any orders yet.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>