<%@page import="java.util.List"%>
<%@page import="org.example.motor_showroom.Models.User"%>
<%@page import="org.example.motor_showroom.Models.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --sidebar-bg: rgba(30, 30, 30, 0.95);
            --sidebar-text: #e0e0e0;
            --primary-bg: rgba(0, 0, 0, 0.6);
            --card-bg: rgba(255, 255, 255, 0.08);
            --accent: #c49b66;
            --velvet-green: #2f3b2f;
            --danger: #a63636;
            --pending: #ffb400;
            --completed: #28a745;
            --cancelled: #dc3545;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            background: url("../uploads/admindashboard.jpg") no-repeat center center fixed;
            background-size: cover;
            color: #f5f5f5;
        }

        body::before {
            content: "";
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        .sidebar {
            width: 220px;
            background-color: var(--sidebar-bg);
            color: var(--sidebar-text);
            height: 100vh;
            padding: 20px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            backdrop-filter: blur(8px);
        }

        .sidebar .logo {
            font-size: 1.7rem;
            font-weight: 600;
            color: var(--accent);
            margin-bottom: 30px;
        }

        .sidebar nav a {
            display: block;
            color: var(--sidebar-text);
            text-decoration: none;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 10px;
            transition: background 0.3s;
        }

        .sidebar nav a:hover,
        .sidebar nav a.active {
            background-color: var(--velvet-green);
        }

        .main {
            margin-left: 220px;
            padding: 40px;
            width: calc(100% - 220px);
            background-color: var(--primary-bg);
            backdrop-filter: blur(6px);
            min-height: 100vh;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0;
            font-size: 2rem;
            color: #fdfdfd;
        }

        .logout-btn {
            background-color: var(--danger);
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background-color: #8a2e2e;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
        }

        .alert-success {
            background-color: rgba(40, 167, 69, 0.2);
            color: #d4edda;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .alert-error {
            background-color: rgba(220, 53, 69, 0.2);
            color: #f8d7da;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: 8px;
            overflow: hidden;
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #f2f2f2;
        }

        th {
            background-color: rgba(255, 255, 255, 0.1);
            color: #fdfdfd;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .btn {
            padding: 8px 14px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            font-size: 0.9rem;
            transition: background 0.3s;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #8a2e2e;
        }

        select {
            padding: 8px;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            color: white;
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

        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .main {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("Admin")) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<div class="sidebar">
    <div class="logo">Admin Panel</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/motors">Manage Motors</a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="active">Manage Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
    </nav>
</div>

<div class="main">
    <div class="header">
        <h1>Manage Orders</h1>
        <button class="logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">LOGOUT</button>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getParameter("error") %>
    </div>
    <% } %>

    <table>
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
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
        %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getCustomerName() != null ? order.getCustomerName() : "N/A" %></td>
            <td><%= order.getMotorName() %></td>
            <td><%= order.getOrderType() %></td>
            <td>$<%= String.format("%.2f", order.getTotalAmount()) %></td>
            <td>
                <form method="POST" action="${pageContext.request.contextPath}/admin/orders" style="display: inline;">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                    <select name="status" onchange="this.form.submit()"
                            style="background-color: <%= getStatusColor(order.getStatus()) %>; color: white; border: none;">
                        <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Completed</option>
                        <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </form>
            </td>
            <td><%= order.getOrderDate() %></td>
            <td>
                <form method="POST" action="${pageContext.request.contextPath}/admin/orders" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Are you sure you want to delete this order?')">
                        Delete
                    </button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" style="text-align: center; color: #777;">No orders found</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
<%!
    private String getStatusColor(String status) {
        switch (status) {
            case "Pending": return "#ffb400";
            case "Completed": return "#28a745";
            case "Cancelled": return "#dc3545";
            default: return "#6c757d";
        }
    }
%>