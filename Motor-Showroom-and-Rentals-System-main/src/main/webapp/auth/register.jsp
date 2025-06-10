<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Motor Showroom - Register</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow: hidden;
        }

        .image-side {
            background: url("../uploads/registerpage.png") no-repeat center center;
            background-size: cover;
            height: 100vh;
            width: 100vw;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding: 2rem;
            box-sizing: border-box;
        }

        .form-side {
            width: 100%;
            max-width: 460px;
            backdrop-filter: blur(6px);
            margin-left: 5%;
        }


        .auth-card {
            background: rgba(255, 255, 255, 0.08);
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.4);
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
            color: #ddd;
        }

        .form-control, textarea {
            width: 100%;
            padding: 0.6rem;
            border: none;
            border-radius: 8px;
            background: #f3f3f3;
            font-size: 1rem;
        }

        .role-options {
            display: flex;
            gap: 1rem;
            margin-top: 0.5rem;
        }

        .role-options label {
            color: #ddd;
        }

        .btn {
            background-color: #ff6f00;
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
            background-color: #e65c00;
        }

        .alert.error {
            background: #ff4d4d;
            color: white;
            padding: 0.6rem;
            margin-bottom: 1rem;
            border-radius: 6px;
            text-align: center;
        }

        a {
            color: #ffd700;
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
            <h2>Register</h2>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="form-group">
                    <label class="form-label" for="username">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm Password:</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="address">Address:</label>
                    <textarea class="form-control" id="address" name="address" rows="3"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Role:</label>
                    <div class="role-options">
                        <label><input type="radio" name="role" value="Customer" checked> Customer</label>
                        <label><input type="radio" name="role" value="Admin"> Admin</label>
                    </div>
                </div>

                <button type="submit" class="btn">Register</button>
            </form>

            <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login.jsp">Login here</a></p>
        </div>
    </div>
</div>
</body>
</html>
