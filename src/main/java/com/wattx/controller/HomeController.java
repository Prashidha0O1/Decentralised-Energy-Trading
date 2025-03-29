package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/home", "/index", "/Register" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String birthday = request.getParameter("birthday");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String password = request.getParameter("password");
        String retypePassword = request.getParameter("retypePassword");

        System.out.println("First Name: " + firstName);
        System.out.println("Last Name: " + lastName);
        System.out.println("Username: " + username);
        System.out.println("Birthday: " + birthday);
        System.out.println("Gender: " + gender);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        System.out.println("Subject: " + subject);
        System.out.println("Password: " + password);
        System.out.println("Retype Password: " + retypePassword);

        List<String> errors = new ArrayList<>();

        if (firstName == null || firstName.trim().isEmpty() || !isValidName(firstName)) {
            errors.add("First Name must not be empty and contain no numbers or special characters.");
            System.out.println("Validation Error: Invalid First Name");
        }
        if (lastName == null || lastName.trim().isEmpty() || !isValidName(lastName)) {
            errors.add("Last Name must not be empty and contain no numbers or special characters.");
            System.out.println("Validation Error: Invalid Last Name");
        }

        if (username == null || username.trim().isEmpty() || !isValidUsername(username)) {
            errors.add("Username must be more than 6 characters and contain no special characters.");
            System.out.println("Validation Error: Invalid Username");
        }

        if (birthday == null || birthday.trim().isEmpty()) {
            errors.add("Birthday is required.");
            System.out.println("Validation Error: Birthday is required");
        } else {
            try {
                LocalDate dob = LocalDate.parse(birthday, DateTimeFormatter.ISO_LOCAL_DATE);
                if (dob.isAfter(LocalDate.now())) {
                    errors.add("Birthday cannot be in the future.");
                    System.out.println("Validation Error: Birthday in future");
                }
            } catch (Exception e) {
                errors.add("Invalid Birthday format.");
                System.out.println("Validation Error: Invalid Birthday format - " + e.getMessage());
            }
        }

        if (phone == null || phone.trim().isEmpty() || !isValidPhoneNumber(phone)) {
            errors.add("Phone Number must start with '+' and be 14 characters (e.g., +1234567890123).");
            System.out.println("Validation Error: Invalid Phone Number");
        }

        if (password == null || password.trim().isEmpty() || !isValidPassword(password, retypePassword)) {
            errors.add("Password must be more than 6 characters, contain a number, a special character, an uppercase letter, and match the retyped password.");
            System.out.println("Validation Error: Invalid Password");
        }

        if (gender == null || gender.trim().isEmpty()) {
            errors.add("Gender is required.");
            System.out.println("Validation Error: Gender is required");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required.");
            System.out.println("Validation Error: Email is required");
        }

        if (subject == null || subject.trim().isEmpty()) {
            errors.add("Subject is required.");
            System.out.println("Validation Error: Subject is required");
        }

        if (isDuplicateData(username, email, phone)) {
            errors.add("Username, email, or phone number already exists.");
            System.out.println("Validation Error: Duplicate data detected");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("username", username);
            request.setAttribute("birthday", birthday);
            request.setAttribute("gender", gender);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("subject", subject);
            System.out.println("Errors detected, redisplaying form with " + errors.size() + " errors.");
            doGet(request, response);
            return;
        }

        int result = addStudent(firstName, lastName, username, birthday, gender, email, phone, subject, password);

        if (result == 1) {
            System.out.println("Registration successful, redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        } else {
            errors.add("Registration failed due to an internal error.");
            System.out.println("Registration failed due to an internal error.");
            request.setAttribute("errors", errors);
            doGet(request, response);
        }
    }

    private boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) return false;
        return !name.matches(".*\\d.*") && !name.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
    }

    private boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) return false;
        return username.length() > 6 && !username.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) return false;
        return phoneNumber.startsWith("+") && phoneNumber.length() == 14;
    }

    private boolean isValidPassword(String password, String retypePassword) {
        if (password == null || retypePassword == null || password.trim().isEmpty()) return false;
        return password.length() > 6 && 
               password.matches(".*\\d.*") && 
               password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*") &&
               password.matches(".*[A-Z].*") && 
               password.equals(retypePassword);
    }

    private boolean isDuplicateData(String username, String email, String phone) {
        return false;
    }

    private int addStudent(String firstName, String lastName, String username, String birthday, 
                          String gender, String email, String phone, String subject, String password) {
        System.out.println("Student added: " + username);
        return 1;
    }
}