<%@page import="java.util.List,org.example.motor_showroom.Models.Motor,org.example.motor_showroom.Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Motors</title>
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

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #ddd;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 6px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 15px;
            background-color: rgba(255, 255, 255, 0.05);
            color: #fff;
        }

        button, .btn {
            background-color: var(--accent);
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }

        button:hover, .btn:hover {
            background-color: #b4874e;
        }

        .motors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .motor-card {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(6px);
        }

        .motor-card img {
            width: 100%;
            height: auto;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        .motor-card h3 {
            margin: 0;
            color: var(--accent);
        }

        .motor-card p {
            margin: 4px 0;
            color: #ddd;
        }

        .motor-card .actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 12px;
        }

        .btn-danger {
            background-color: var(--danger);
        }

        .btn-danger:hover {
            background-color: #8a2e2e;
        }

        .section-title {
            margin-top: 20px;
            margin-bottom: 12px;
            font-size: 1.5rem;
            color: #fdfdfd;
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
    if (user == null || !"Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<div class="sidebar">
    <div class="logo">Admin Panel</div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/motors" class="active">Manage Motors</a>
        <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
    </nav>
</div>

<div class="main">
    <div class="header">
        <h1>Manage Motors</h1>
        <button class="logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">LOGOUT</button>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success"><%= request.getParameter("success") %></div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-error"><%= request.getParameter("error") %></div>
    <% } %>

    <h2 class="section-title">Add New Motor</h2>
    <form method="POST" action="${pageContext.request.contextPath}/admin/motors" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Type:</label>
        <select name="type" required>
            <option value="Electric">Electric</option>
            <option value="Petrol">Petrol</option>
            <option value="Diesel">Diesel</option>
        </select>

        <label>Power (kW):</label>
        <input type="number" step="0.01" name="power" required>

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required>

        <label>Description:</label>
        <textarea name="description" required></textarea>

        <label>Image:</label>
        <input type="file" name="image" accept="image/*" required>

        <button type="submit">Add Motor</button>
    </form>

    <h2 class="section-title">All Motors</h2>
    <div class="motors-grid">
        <%
            List<Motor> motors = (List<Motor>) request.getAttribute("allMotors");
            if (motors != null && !motors.isEmpty()) {
                for (Motor motor : motors) {
        %>
        <div class="motor-card">
            <img src="${pageContext.request.contextPath}/<%= motor.getImagePath() %>" alt="<%= motor.getName() %>">
            <h3><%= motor.getName() %></h3>
            <p>Type: <%= motor.getType() %></p>
            <p>Power: <%= motor.getPower() %> kW</p>
            <p>Price: $<%= motor.getPrice() %></p>
            <p>Status: <%= motor.isAvailability() ? "Available" : "Out of Stock" %></p>
            <div class="actions">
                <a href="motors?action=edit&id=<%= motor.getMotorId() %>" class="btn">Edit</a>
                <a href="motors?action=toggle&id=<%= motor.getMotorId() %>" class="btn">
                    <%= motor.isAvailability() ? "Mark Unavailable" : "Mark Available" %>
                </a>
                <form action="${pageContext.request.contextPath}/admin/motors" method="post" onsubmit="return confirm('Are you sure you want to delete this motor?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="motorId" value="<%= motor.getMotorId() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
        <%
            }
        } else { %>
        <div style="grid-column: 1 / -1; text-align: center; color: #777;">No motors found</div>
        <% } %>
    </div>
</div>
</body>
</html>