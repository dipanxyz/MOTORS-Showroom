<%@page import="org.example.motor_showroom.Models.User"%>
<%@page import="java.util.List"%>
<%@page import="org.example.motor_showroom.Models.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --sidebar-bg: rgba(30, 30, 30, 0.95);
            --sidebar-text: #e0e0e0;
            --primary-bg: rgba(0, 0, 0, 0.6);
            --card-bg: rgba(255, 255, 255, 0.08);
            --accent: #c49b66;
            --velvet-green: #2f3b2f;
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
            background-color: rgba(0, 0, 0, 0.6); /* dark overlay for readability */
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
            background-color: #a63636;
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

        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .stat-card {
            flex: 1 1 220px;
            background-color: var(--card-bg);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            text-align: center;
            backdrop-filter: blur(6px);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .stat-title {
            color: #ddd;
            font-size: 1.1rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--accent);
            margin-top: 10px;
        }

        .section-title {
            margin-top: 20px;
            margin-bottom: 12px;
            font-size: 1.5rem;
            color: #fdfdfd;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: 8px;
            overflow: hidden;
            backdrop-filter: blur(4px);
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

        .status {
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            color: #fff;
        }

        .pending {
            background-color: #ffb400;
        }

        .completed {
            background-color: #28a745;
        }

        .cancelled {
            background-color: #dc3545;
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

            .stats {
                flex-direction: column;
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/motors">Manage Motors</a>
        <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
    </nav>
</div>

<div class="main">
    <div class="header">
        <h1>Welcome, Admin</h1>
        <button class="logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">LOGOUT</button>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-title">Total Motors</div>
            <div class="stat-value"><%= request.getAttribute("totalMotors") %></div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Total Orders</div>
            <div class="stat-value"><%= request.getAttribute("totalOrders") %></div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Total Users</div>
            <div class="stat-value"><%= request.getAttribute("totalUsers") %></div>
        </div>
    </div>

    <h2 class="section-title">Recent Orders</h2>
    <table>
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Motor</th>
            <th>Type</th>
            <th>Total</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("recentOrders");
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
        %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getMotorName() %></td>
            <td><%= order.getOrderType() %></td>
            <td>$<%= String.format("%.2f", order.getTotalAmount()) %></td>
            <td>
                <span class="status <%= order.getStatus().toLowerCase() %>">
                    <%= order.getStatus() %>
                </span>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" style="text-align: center; color: #777;">No recent orders available</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
