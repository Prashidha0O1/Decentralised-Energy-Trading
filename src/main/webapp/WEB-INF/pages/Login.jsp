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