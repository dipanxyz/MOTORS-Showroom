<%@page import="org.example.motor_showroom.Models.Motor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Order Motor</title>
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
      padding: 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .error-message {
      background: #f8d7da;
      color: #721c24;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 4px;
    }
    .motor-details {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
    }
    .motor-image {
      flex: 1;
    }
    .motor-image img {
      max-width: 100%;
      height: auto;
      border-radius: 8px;
    }
    .motor-info {
      flex: 2;
    }
    .form-group {
      margin-bottom: 20px;
    }
    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
    }
    select, input, textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ced4da;
      border-radius: 4px;
      font-size: 16px;
    }
    .btn {
      background-color: #007bff;
      color: white;
      padding: 12px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
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

  Motor motor = (Motor) request.getAttribute("motor");
  if (motor == null) {
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
  <% if (request.getParameter("error") != null) { %>
  <div class="error-message">
    <%= request.getParameter("error") %>
  </div>
  <% } %>

  <div class="motor-details">
    <div class="motor-image">
      <img src="${pageContext.request.contextPath}/<%= motor.getImagePath() %>"
           alt="<%= motor.getName() %>"
           onerror="this.src='${pageContext.request.contextPath}/resources/images/default-motor.jpg'">
    </div>
    <div class="motor-info">
      <h2><%= motor.getName() %></h2>
      <p><strong>Type:</strong> <%= motor.getType() %></p>
      <p><strong>Power:</strong> <%= motor.getPower() %> kW</p>
      <p><strong>Price:</strong> $<%= String.format("%.2f", motor.getPrice()) %></p>
      <p><strong>Status:</strong> <%= motor.isAvailability() ? "Available" : "Out of Stock" %></p>
    </div>
  </div>

  <form method="POST" action="${pageContext.request.contextPath}/customer/order">
    <input type="hidden" name="motorId" value="<%= motor.getMotorId() %>">

    <div class="form-group">
      <label for="orderType">Order Type:</label>
      <select name="orderType" id="orderType" required>
        <option value="Buy">Buy</option>+656
        <option value="Rent">Rent</option>
      </select>
    </div>

    <div class="form-group" id="rentDurationGroup" style="display: none;">
      <label for="rentDuration">Rental Duration (days):</label>
      <input type="number" name="rentDuration" id="rentDuration" min="1" value="1">
    </div>

    <div class="form-group">
      <label for="deliveryAddress">Delivery Address:</label>
      <textarea name="deliveryAddress" id="deliveryAddress" required></textarea>
    </div>

    <div class="form-group">
      <label for="paymentMethod">Payment Method:</label>
      <select name="paymentMethod" id="paymentMethod" required>
        <option value="Credit Card">Credit Card</option>
        <option value="Debit Card">Debit Card</option>
        <option value="Bank Transfer">Bank Transfer</option>
      </select>
    </div>

    <button type="submit" class="btn">Place Order</button>
  </form>
</div>

<script>
  document.getElementById('orderType').addEventListener('change', function() {
    const rentGroup = document.getElementById('rentDurationGroup');
    rentGroup.style.display = this.value === 'Rent' ? 'block' : 'none';
    if (this.value === 'Rent') {
      document.getElementById('rentDuration').required = true;
    } else {
      document.getElementById('rentDuration').required = false;
    }
  });
</script>
</body>
</html>