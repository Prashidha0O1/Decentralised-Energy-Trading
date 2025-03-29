<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/styles.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #e07ad5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }
    .container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 30px;
        width: 100%;
        max-width: 800px;
    }
    h1 {
        text-align: center;
        color: #333;
        margin-bottom: 30px;
    }
    .form-row {
        display: flex;
        flex-wrap: wrap;
        margin: 0 -10px;
    }
    .form-group {
        width: 40%;
        padding: 20px;
        padding-left: 50px;
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
        color: #555;
        font-weight: 500;
    }
    input, select {
        width: 70%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }
    button {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
        margin-left: 50px;
    }
    button:hover {
        background-color: #45a049;
    }
    .error-container {
        background-color: #ffebee;
        border: 1px solid #ef5350;
        border-radius: 4px;
        padding: 15px;
        margin-bottom: 20px;
    }
    .error {
        color: #d32f2f;
        margin: 5px 0;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Registration Form</h1>
        <% 
            List<String> errors = (List<String>) request.getAttribute("errors");
            if (errors != null && !errors.isEmpty()) {
        %>
            <div class="error-container">
                <% for (String error : errors) { %>
                    <p class="error"><%= error %></p>
                <% } %>
            </div>
        <% } %>
        <form action="Register" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>">
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                </div>
                <div class="form-group">
                    <label for="birthday">Birthday:</label>
                    <input type="date" id="birthday" name="birthday" value="<%= request.getAttribute("birthday") != null ? request.getAttribute("birthday") : "" %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender">
                        <option value="">Select Gender</option>
                        <option value="male" <%= "male".equals(request.getAttribute("gender")) ? "selected" : "" %>>Male</option>
                        <option value="female" <%= "female".equals(request.getAttribute("gender")) ? "selected" : "" %>>Female</option>
                        <option value="other" <%= "other".equals(request.getAttribute("gender")) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="phone">Phone Number:</label>
                    <input type="tel" id="phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
                </div>
                <div class="form-group">
                    <label for="subject">Subject:</label>
                    <select id="subject" name="subject">
                        <option value="">Select Subject</option>
                        <option value="computing" <%= "computing".equals(request.getAttribute("subject")) ? "selected" : "" %>>Computing</option>
                        <option value="mathematics" <%= "mathematics".equals(request.getAttribute("subject")) ? "selected" : "" %>>AI</option>
                        <option value="science" <%= "science".equals(request.getAttribute("subject")) ? "selected" : "" %>>Networking</option>
                        <option value="arts" <%= "arts".equals(request.getAttribute("subject")) ? "selected" : "" %>>Cyber Security</option>
                        <option value="engineering" <%= "engineering".equals(request.getAttribute("subject")) ? "selected" : "" %>>Business</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password">
                </div>
                <div class="form-group">
                    <label for="retypePassword">Retype Password:</label>
                    <input type="password" id="retypePassword" name="retypePassword">
                </div>
            </div>
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>