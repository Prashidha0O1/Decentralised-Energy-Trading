<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #F0B90B;
            --secondary: #1E2026;
            --text-primary: #F3F3F3;
            --text-secondary: #848E9C;
            --bg-primary: #0B0E11;
            --bg-secondary: #1E2026;
            --bg-tertiary: #2B3139;
            --success: #02C076;
            --danger: #F6465D;
            --border: #2E333A;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
        
        body {
            background-color: var(--bg-primary);
            color: var(--text-primary);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(240, 185, 11, 0.03) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(240, 185, 11, 0.03) 0%, transparent 20%);
        }
        
        .auth-container {
            display: flex;
            width: 100%;
            max-width: 1200px;
            height: 700px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            border-radius: 15px;
            overflow: hidden;
        }
        
        .auth-banner {
            flex: 1;
            background-color: var(--bg-secondary);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            background-image: 
                linear-gradient(135deg, rgba(240, 185, 11, 0.1) 0%, transparent 100%),
                radial-gradient(circle at 50% 50%, rgba(240, 185, 11, 0.05) 0%, transparent 60%);
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 40px;
        }
        
        .logo-icon {
            width: 50px;
            height: 50px;
            background-color: var(--primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            color: var(--bg-primary);
        }
        
        .logo-text {
            font-size: 28px;
            font-weight: bold;
        }
        
        .banner-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .banner-description {
            font-size: 16px;
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        
        .banner-features {
            width: 100%;
            margin-bottom: 30px;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .feature-icon {
            width: 40px;
            height: 40px;
            background-color: rgba(240, 185, 11, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary);
        }
        
        .feature-text {
            flex: 1;
        }
        
        .feature-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 5px;
        }
        
        .feature-description {
            font-size: 14px;
            color: var(--text-secondary);
        }
        
        .auth-form {
            flex: 1;
            background-color: var(--bg-tertiary);
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow-y: auto;
        }
        
        .form-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .form-subtitle {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 30px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group.full-width {
            grid-column: span 2;
        }
        
        .form-label {
            display: block;
            font-size: 14px;
            margin-bottom: 8px;
            color: var(--text-secondary);
        }
        
        .form-input {
            width: 100%;
            background-color: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 5px;
            padding: 12px 15px;
            color: var(--text-primary);
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(240, 185, 11, 0.2);
        }

        .form-input:invalid {
            border-color: var(--danger);
        }
        
        .password-requirements {
            margin-top: 10px;
            font-size: 12px;
            color: var(--text-secondary);
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }
        
        .requirement i {
            margin-right: 5px;
            font-size: 12px;
        }
        
        .terms {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .terms input {
            margin-right: 10px;
            margin-top: 3px;
        }
        
        .terms label {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.4;
        }
        
        .terms a {
            color: var(--primary);
            text-decoration: none;
        }
        
        .terms a:hover {
            text-decoration: underline;
        }
        
        .submit-btn {
            width: 100%;
            background-color: var(--primary);
            color: var(--secondary);
            border: none;
            border-radius: 5px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 20px;
        }
        
        .submit-btn:hover {
            background-color: #e0ad0a;
            transform: translateY(-2px);
        }
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        .login-link {
            text-align: center;
            font-size: 14px;
            color: var(--text-secondary);
        }
        
        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            color: var(--danger);
            font-size: 14px;
            margin-top: 5px;
        }
        
        /* Responsive styles */
        @media (max-width: 992px) {
            .auth-container {
                max-width: 90%;
                height: auto;
                flex-direction: column;
            }
            
            .auth-banner {
                padding: 30px;
            }
            
            .auth-form {
                padding: 30px;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-group.full-width {
                grid-column: span 1;
            }
        }
        
        @media (max-width: 576px) {
            .auth-container {
                max-width: 100%;
                height: 100%;
                border-radius: 0;
            }
            
            .auth-banner {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-banner">
            <div class="logo">
                <div class="logo-icon">W</div>
                <div class="logo-text">WattX</div>
            </div>
            <h2 class="banner-title">Join the Energy Revolution</h2>
            <p class="banner-description">Create an account to start trading renewable energy on our secure blockchain platform.</p>
            
            <div class="banner-features">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="feature-text">
                        <h4 class="feature-title">Secure Transactions</h4>
                        <p class="feature-description">Trade with confidence on our blockchain platform</p>
                    </div>
                </div>
                
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <div class="feature-text">
                        <h4 class="feature-title">Fast Trading</h4>
                        <p class="feature-description">Instant peer-to-peer energy trading</p>
                    </div>
                </div>
                
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="feature-text">
                        <h4 class="feature-title">Real-time Analytics</h4>
                        <p class="feature-description">Track your energy production and consumption</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="auth-form">
            <h2 class="form-title">Create an Account</h2>
            <p class="form-subtitle">Complete the form below to join WattX</p>
            
            <form action="register" method="post" id="registerForm" novalidate>
                <% 
                // Check if there's an error message to display
                String error = request.getParameter("error");
                if (error != null) {
                %>
                <div class="error-message" style="margin-bottom: 15px;">
                    <%= error %>
                </div>
                <% } %>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" id="firstName" name="firstName" class="form-input" placeholder="Enter your first name" required oninvalid="this.setCustomValidity('First name is required')" oninput="this.setCustomValidity('')">
                    </div>
                    
                    <div class="form-group">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" id="lastName" name="lastName" class="form-input" placeholder="Enter your last name" required oninvalid="this.setCustomValidity('Last name is required')" oninput="this.setCustomValidity('')">
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" name="email" class="form-input" placeholder="Enter your email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" oninvalid="this.setCustomValidity('Please enter a valid email address')" oninput="this.setCustomValidity('')">
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="Create a password" 
                            required 
                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" 
                            title="Password must be at least 8 characters with at least one uppercase letter, one lowercase letter, and one number"
                            oninvalid="this.setCustomValidity('Password must meet all requirements')" 
                            oninput="this.setCustomValidity('')">
                        <div class="password-requirements">
                            <div class="requirement">
                                <i class="fas fa-circle"></i> At least 8 characters
                            </div>
                            <div class="requirement">
                                <i class="fas fa-circle"></i> At least one uppercase letter
                            </div>
                            <div class="requirement">
                                <i class="fas fa-circle"></i> At least one lowercase letter
                            </div>
                            <div class="requirement">
                                <i class="fas fa-circle"></i> At least one number
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Confirm your password" required oninvalid="this.setCustomValidity('Please confirm your password')" oninput="this.setCustomValidity(''); if(this.value !== document.getElementById('password').value) this.setCustomValidity('Passwords do not match');">
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="userType" class="form-label">Account Type</label>
                        <select id="userType" name="userType" class="form-input" required oninvalid="this.setCustomValidity('Please select an account type')" oninput="this.setCustomValidity('')">
                            <option value="" disabled selected>Select account type</option>
                            <option value="consumer">Energy Consumer</option>
                            <option value="producer">Energy Producer</option>
                            <option value="prosumer">Prosumer (Both)</option>
                        </select>
                    </div>
                </div>
                
                <div class="terms">
                    <input type="checkbox" id="terms" name="terms" required oninvalid="this.setCustomValidity('You must accept the terms and conditions')" oninput="this.setCustomValidity('')">
                    <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>. I understand that my personal data will be processed in accordance with WattX's <a href="#">Privacy Policy</a>.</label>
                </div>
                
                <button type="submit" class="submit-btn">Create Account</button>
                
                <p class="login-link">
                    Already have an account? <a href="<%= contextPath %>/login">Log in</a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>