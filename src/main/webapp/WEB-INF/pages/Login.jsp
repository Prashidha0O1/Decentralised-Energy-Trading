<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        /* Crypto Pattern Overlay */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(0, 102, 255, 0.15) 0%, transparent 20%),
                radial-gradient(circle at 80% 70%, rgba(0, 255, 204, 0.15) 0%, transparent 20%),
                linear-gradient(45deg, transparent 48%, rgba(0, 102, 255, 0.1) 48%, rgba(0, 102, 255, 0.1) 52%, transparent 52%),
                linear-gradient(-45deg, transparent 48%, rgba(0, 255, 204, 0.1) 48%, rgba(0, 255, 204, 0.1) 52%, transparent 52%);
            background-size: 100px 100px;
            opacity: 0.8;
            z-index: -1;
        }

        /* Login Container */
        .login-container {
            background: rgba(10, 14, 23, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(8px);
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Logo */
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo h1 {
            color: white;
            font-size: 28px;
            font-weight: bold;
            margin-top: 10px;
        }

        .logo-icon {
            background-color: #0066ff;
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: white;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #0066ff;
            box-shadow: 0 0 0 2px rgba(0, 102, 255, 0.3);
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 38px;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Button */
        .login-btn {
            width: 100%;
            padding: 14px;
            background-color: #0066ff;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .login-btn:hover {
            background-color: #0055cc;
        }

        /* Footer Links */
        .footer-links {
            text-align: center;
            margin-top: 20px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }

        .footer-links a {
            color: #0066ff;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #0055cc;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
                margin: 0 15px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <div class="logo-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L3 6V18L12 22L21 18V6L12 2Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M12 22V12" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7 12L17 7" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h1>WattX</h1>
        </div>

        <form action="<%= contextPath %>/login" method="POST">
            <div class="form-group">
                <label for="email">Email</label>
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>

        <div class="footer-links">
            <p>New to WattX? <a href="<%= contextPath %>/register">Create an account</a></p>
            <p><a href="<%= contextPath %>/forgot-password">Forgot password?</a></p>
        </div>
    </div>
</body>
</html>