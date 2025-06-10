<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Motor Showroom</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background: url("uploads/landingpage.png") no-repeat center center/cover;
            color: #fff;
            height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: flex-start;
            padding: 60px;
            text-align: left;
        }

        .logo {
            font-size: 2.8rem;
            font-weight: 700;
            letter-spacing: 5px;
            margin-bottom: 40px;
            color: #ffffff;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
        }

        .tagline {
            font-size: 3.2rem;
            font-weight: 300;
            margin-bottom: 50px;
            line-height: 1.2;
            max-width: 600px;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.7);
        }

        .auth-buttons {
            display: flex;
            gap: 30px;
        }

        .auth-button {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #fff;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            padding: 12px 24px;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s, transform 0.2s;
        }

        .auth-button:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .auth-button::after {
            content: '→';
            margin-left: 8px;
            transition: transform 0.3s;
        }

        .auth-button:hover::after {
            transform: translateX(5px);
        }
    </style>
</head>
<body>
<div>
    <div class="logo">Motor <br>Showroom</div>
    <div class="tagline">LET'S GET YOU<br>ON THE ROAD</div>
    <div class="auth-buttons">
        <a href="${pageContext.request.contextPath}/auth/login.jsp" class="auth-button">LOGIN</a>
        <a href="${pageContext.request.contextPath}/auth/register.jsp" class="auth-button">SIGNUP</a>
    </div>
</div>
</body>
</html>
