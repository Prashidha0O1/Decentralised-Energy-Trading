<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
    <style>
    :root {
            --binance-yellow: #F0B90B;
            --binance-black: #1A1A1A;
            --binance-dark-gray: #2A2A2A;
            --binance-light-gray: #B0B0B0;
            --binance-text: #F3F3F3;
            --binance-border: #4A4A4A;
            --error-border: #FF4D4F;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', 'Arial', sans-serif;
        }

        body {
            background: var(--binance-black);
            color: var(--binance-text);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: auto;
        }

        body::before {
            content: "";
            position: absolute;
            bottom: 0;
            right: 0;
            width: 60%;
            height: 60%;
            background: 
                linear-gradient(135deg, var(--binance-yellow) 0%, transparent 100%),
                linear-gradient(45deg, var(--binance-yellow) 0%, var(--binance-black) 100%);
            clip-path: polygon(100% 0%, 100% 100%, 0% 100%, 50% 50%);
            opacity: 0.6;
            z-index: -1;
            animation: fadeInGradient 1s ease-in;
        }

        @keyframes fadeInGradient {
            from { opacity: 0; }
            to { opacity: 0.6; }
        }

        .login-container {
            background: var(--binance-dark-gray);
            border: 1px solid var(--binance-border);
            border-radius: 8px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .logo {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 1.8rem;
            margin-bottom: 30px;
            color: var(--binance-text);
            text-decoration: none;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background-color: var(--binance-yellow);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--binance-black);
            font-size: 1.2rem;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--binance-border);
            border-radius: 4px;
            color: var(--binance-text);
            font-size: 14px;
            transition: all 0.2s;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--binance-yellow);
            box-shadow: 0 0 0 2px rgba(240, 185, 11, 0.3);
        }

        .form-group input.invalid {
            border-color: var(--error-border);
            box-shadow: 0 0 0 2px rgba(255, 77, 79, 0.3);
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 12px;
            color: var(--binance-light-gray);
            font-size: 14px;
        }

        .form-group label {
            display: block;
            color: var(--binance-light-gray);
            margin-top: 8px;
            font-size: 14px;
        }

        .error-message {
            color: var(--error-border);
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .error-message.active {
            display: block;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background-color: var(--binance-yellow);
            color: var(--binance-black);
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 10px;
        }

        .login-btn:hover {
            background-color: #d4a009;
        }

        .footer-links {
            text-align: center;
            margin-top: 20px;
            color: var(--binance-light-gray);
            font-size: 14px;
        }

        .footer-links a {
            color: var(--binance-yellow);
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: #d4a009;
        }

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
        <a href="<%= contextPath %>/" class="logo">
            <div class="logo-icon"><i class="fas fa-wallet"></i></div>
            WattX
        </a>

        <form id="loginForm" action="<%= contextPath %>/login" method="POST">
            <div class="form-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                <label for="email">Email</label>
                <div id="emailError" class="error-message"></div>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <label for="password">Password</label>
                <div id="passwordError" class="error-message"></div>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>

        <div class="footer-links">
            <p>New to WattX? <a href="<%= contextPath %>/register">Create an account</a></p>
            <p><a href="<%= contextPath %>/forgot-password">Forgot password?</a></p>
        </div>
    </div>

    <script>
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const emailError = document.getElementById('emailError');
        const passwordError = document.getElementById('passwordError');

        // Validation patterns
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;

        // Function to validate a field and update its UI
        function validateField(input, pattern, errorElement, errorMessage) {
            const value = input.value.trim();
            if (value === '') {
                // Don't show validation errors for empty fields (let HTML5 'required' handle it)
                input.classList.remove('invalid');
                errorElement.textContent = '';
                errorElement.classList.remove('active');
            } else if (!pattern.test(value)) {
                input.classList.add('invalid');
                errorElement.textContent = errorMessage;
                errorElement.classList.add('active');
            } else {
                input.classList.remove('invalid');
                errorElement.textContent = '';
                errorElement.classList.remove('active');
            }
        }

        // Real-time validation on input
        emailInput.addEventListener('input', () => {
            validateField(
                emailInput,
                emailPattern,
                emailError,
                'Please enter a valid email address (e.g., user@domain.com).'
            );
        });

        passwordInput.addEventListener('input', () => {
            validateField(
                passwordInput,
                passwordPattern,
                passwordError,
                'Password must be at least 8 characters, with 1 uppercase, 1 lowercase, 1 number, and 1 special character.'
            );
        });
    </script>
</body>
</html>