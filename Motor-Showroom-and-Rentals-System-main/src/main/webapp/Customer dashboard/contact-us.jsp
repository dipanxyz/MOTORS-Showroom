<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Contact Us</title>
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
      max-width: 600px;
      margin: auto;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .section-title {
      font-size: 1.5rem;
      margin-bottom: 20px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
      margin-bottom: 5px;
    }
    input, textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ced4da;
      border-radius: 4px;
    }
    .btn {
      background-color: #007bff;
      color: white;
      padding: 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="navbar">
  <a href="${pageContext.request.contextPath}/customer/dashboard">Home</a>
  <a href="${pageContext.request.contextPath}/customer/order">My Orders</a>
  <a href="${pageContext.request.contextPath}/Customer dashboard/about-us.jsp">About Us</a>
  <a href="${pageContext.request.contextPath}/Customer dashboard/contact-us.jsp">Contact Us</a>
  <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>
<div class="container">
  <h1 class="section-title">Contact Us</h1>
  <div class="contact-grid">
    <div class="contact-info-section">
      <div class="info-item">
        <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
        <div class="info-content">
          <h3>Our Location</h3>
          <p>123 Motor Street, Tech City</p>
        </div>
      </div>
    </div>

    <form class="contact-form" method="POST" action="${pageContext.request.contextPath}/contact">
      <div class="form-group">
        <label>Name:</label>
        <input type="text" name="name" required>
      </div>
      <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" required>
      </div>
      <div class="form-group">
        <label>Message:</label>
        <textarea name="message" required></textarea>
      </div>
      <button type="submit" class="btn">Send Message</button>
    </form>
  </div>
</div>
</body>
</html>