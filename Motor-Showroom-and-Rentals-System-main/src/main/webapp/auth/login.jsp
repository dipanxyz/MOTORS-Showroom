<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Motor Showroom - Login</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow: hidden;
        }

        .image-side {
            background: url("../uploads/loginpage.png") no-repeat center center;
            background-size: cover;
            height: 100vh;
            width: 100vw;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 2rem;
            box-sizing: border-box;
        }

        .form-side {
            width: 100%;
            max-width: 460px;
            backdrop-filter: blur(6px);
            margin-right: 5%;
        }

        .auth-card {
            background: rgba(32, 32, 32, 0.85);
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.6);
            color: #fff;
        }

        h1, h2 {
            text-align: center;
            margin-bottom: 1rem;
            color: #fff;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #ccc;
        }

        .form-control {
            width: 100%;
            padding: 0.6rem;
            border: none;
            border-radius: 8px;
            background: #2e2e2e;
            color: #fff;
            font-size: 1rem;
        }

        .btn {
            background-color: #b48a62;
            color: white;
            border: none;
            width: 100%;
            padding: 0.8rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #a2744b;
        }

        .alert.error {
            background: #cc3333;
            color: white;
            padding: 0.6rem;
            margin-bottom: 1rem;
            border-radius: 6px;
            text-align: center;
        }

        a {
            color: #f0c674;
            text-decoration: none;
        }

        p {
            text-align: center;
        }

        @media (max-width: 768px) {
            .image-side {
                justify-content: center;
                padding: 1rem;
            }

            .form-side {
                max-width: 100%;
            }
        }
    </style>

</head>
<body>
<div class="image-side">
    <div class="form-side">
        <div class="auth-card">
            <h1>Motor Showroom</h1>
            <h2>Login</h2>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <label class="form-label" for="username">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <button type="submit" class="btn">Login</button>
            </form>

            <p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register.jsp">Register here</a></p>
        </div>
    </div>
</div>
</body>
</html>
