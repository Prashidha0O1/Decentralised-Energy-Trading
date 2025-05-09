package com.wattx.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Email regex pattern for validation
    private static final String EMAIL_REGEX = 
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    // Phone number regex (basic international format, e.g., +1234567890)
    private static final String PHONE_REGEX = 
        "^\\+?[1-9]\\d{1,14}$";
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    /**
     * Validates if the provided email is in a valid format.
     *
     * @param email The email string to validate
     * @return true if the email is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Validates if the provided phone number is in a valid format.
     *
     * @param phoneNumber The phone number string to validate
     * @return true if the phone number is valid, false otherwise
     */
    public static boolean isValidPhoneNumber(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            return false;
        }
        return PHONE_PATTERN.matcher(phoneNumber.trim()).matches();
    }

    /**
     * Checks if the provided string is not null and not empty (after trimming).
     *
     * @param input The string to validate
     * @return true if the string is not null and not empty, false otherwise
     */
    public static boolean isNotNullOrEmpty(String input) {
        return input != null && !input.trim().isEmpty();
    }

    /**
     * Validates if the provided string length is within the specified range.
     *
     * @param input The string to validate
     * @param minLength Minimum length (inclusive)
     * @param maxLength Maximum length (inclusive)
     * @return true if the string length is within the range, false otherwise
     */
    public static boolean isValidLength(String input, int minLength, int maxLength) {
        if (input == null) {
            return false;
        }
        int length = input.trim().length();
        return length >= minLength && length <= maxLength;
    }

    /**
     * Validates if the provided number is positive.
     *
     * @param number The number to validate
     * @return true if the number is positive, false otherwise
     */
    public static boolean isPositiveNumber(Number number) {
        if (number == null) {
            return false;
        }
        return number.doubleValue() > 0;
    }

    /**
     * Validates if the provided string contains only alphabetic characters.
     *
     * @param input The string to validate
     * @return true if the string contains only letters, false otherwise
     */
    public static boolean isAlphabetic(String input) {
        if (input == null || input.trim().isEmpty()) {
            return false;
        }
        return input.trim().matches("^[A-Za-z]+$");
    }

    /**
     * Validates if the provided string contains only alphanumeric characters.
     *
     * @param input The string to validate
     * @return true if the string contains only letters and numbers, false otherwise
     */
    public static boolean isAlphanumeric(String input) {
        if (input == null || input.trim().isEmpty()) {
            return false;
        }
        return input.trim().matches("^[A-Za-z0-9]+$");
    }

    /**
     * Validates if the provided string is a valid number (integer or decimal).
     *
     * @param input The string to validate
     * @return true if the string represents a valid number, false otherwise
     */
    public static boolean isNumeric(String input) {
        if (input == null || input.trim().isEmpty()) {
            return false;
        }
        return input.trim().matches("^-?\\d*\\.?\\d+$");
    }
}