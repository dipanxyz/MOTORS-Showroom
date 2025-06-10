<%@page import="java.util.List"%>
<%@page import="org.example.motor_showroom.Models.Motor"%>
<%@page import="org.example.motor_showroom.Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Customer Dashboard</title>
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f8f9fa;
      color: #343a40;
      margin: 0;
      padding: 20px;
    }
    .navbar {
      background-color: #343a40;
      padding: 10px;
      color: white;
    }
    .navbar a {
      color: white;
      margin-right: 15px;
      text-decoration: none;
    }
    .navbar a:hover {
      text-decoration: underline;
    }
    .container {
      max-width: 1200px;
      margin: auto;
      padding: 20px;
    }
    .section-title {
      font-size: 1.5rem;
      margin-bottom: 20px;
    }
    .vehicles-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }
    .vehicle-card {
      background: white;
      border-radius: 8px;
      padding: 15px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .vehicle-image img {
      width: 100%;
      height: 200px;
      object-fit: contain;
      border-radius: 8px;
    }
    .btn {
      background-color: #007bff;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      margin-top: 10px;
    }
    .btn:hover {
      background-color: #0056b3;
    }
    .empty-state {
      text-align: center;
      color: #dc3545;
      grid-column: 1 / -1;
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
  <a href="${pageContext.request.contextPath}/customer/order">My Orders</a>
  <a href="${pageContext.request.contextPath}/Customer dashboard/about-us.jsp">About Us</a>
  <a href="${pageContext.request.contextPath}/Customer dashboard/contact-us.jsp">Contact Us</a>
  <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>

<div class="container">
  <h2 class="section-title">Available Motors</h2>
  <div class="vehicles-grid">
    <%
      List<Motor> motors = (List<Motor>) request.getAttribute("availableMotors");
      if (motors != null && !motors.isEmpty()) {
        for (Motor motor : motors) {
    %>
    <div class="vehicle-card">
      <div class="vehicle-image">
        <img src="${pageContext.request.contextPath}/<%= motor.getImagePath() %>"
             alt="<%= motor.getName() %>"
             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-motor.jpg'">
      </div>
      <div class="vehicle-details">
        <h3><%= motor.getName() %></h3>
        <p>Type: <%= motor.getType() %></p>
        <p>Price: $<%= String.format("%.2f", motor.getPrice()) %></p>
        <a href="${pageContext.request.contextPath}/customer/order?motorId=<%= motor.getMotorId() %>" class="btn">Order Now</a>
      </div>
    </div>
    <% }} else { %>
    <div class="empty-state">No motors available</div>
    <% } %>
  </div>
</div>
</body>
</html>