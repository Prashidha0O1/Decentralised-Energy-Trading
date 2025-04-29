<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css" />
    
</head>
<body>
    <div class="register-container">
        <a href="<%= contextPath %>/" class="logo">
            <div class="logo-icon"><i class="fas fa-wallet"></i></div>
            WattX
        </a>

        <form id="registerForm" action="<%= contextPath %>/register" method="POST">
            <div class="form-grid">
                <!-- Display Messages -->
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="message success">${success}</div>
                </c:if>

                <div class="form-group">
                    <label for="username">Username</label>
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    <div id="usernameError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    <div id="emailError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <div id="passwordError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="" disabled selected>Select your role</option>
                        <option value="admin">Admin</option>
                        <option value="customer">Customer</option>
                    </select>
                </div>

                <div class="form-group full-width">
                    <button type="submit" class="register-btn">Register</button>
                </div>
            </div>
        </form>

        <div class="footer-links">
            <p>Already have an account? <a href="<%= contextPath %>/login">Login here</a></p>
        </div>
    </div>

    <script>
        const usernameInput = document.getElementById('username');
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const usernameError = document.getElementById('usernameError');
        const emailError = document.getElementById('emailError');
        const passwordError = document.getElementById('passwordError');

        // Validation patterns
        const usernamePattern = /^[a-zA-Z0-9_-]{3,}$/;
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
        usernameInput.addEventListener('input', () => {
            validateField(
                usernameInput,
                usernamePattern,
                usernameError,
                'Username must be at least 3 characters and contain only letters, numbers, underscores, or hyphens.'
            );
        });

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