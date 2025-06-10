<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
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
            max-width: 800px;
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
        .about-text {
            margin-bottom: 20px;
        }
        .stats-grid {
            display: flex;
            justify-content: space-between;
        }
        .stat-item {
            flex: 1;
            text-align: center;
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
    <h1 class="section-title">About Our Motor Showroom</h1>
    <div class="about-content">
        <p class="about-text">
            Welcome to Motor Showroom, your premier destination for high-quality motors since 2020.
            We specialize in providing the best selection of electric, petrol, and diesel motors
            for both personal and industrial use.
        </p>

        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-value">500+</div>
                <div class="stat-label">Happy Customers</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">100+</div>
                <div class="stat-label">Motors Available</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>