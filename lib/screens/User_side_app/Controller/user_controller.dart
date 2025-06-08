import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  // Controllers for email, password, confirm password, phone number, and country code
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController =
      TextEditingController(); // Phone number controller

  // Reactive variables for email, password, confirm password, and phone number
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var phoneNumber = ''.obs; // Reactive variable for phone number

  // Error messages
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var phoneError = ''.obs; // Error message for phone number

  // Reactive variables for obscuring password visibility
  var obscurePassword = true.obs; // Changed to public
  var obscureConfirmPassword = true.obs; // Changed to public

  // Country code related
  var selectedCountryCode = '+1'.obs; // Default country code, e.g., for the USA
  List<String> countryCodes = [
    '+1',
    '+44',
    '+91',
    '+61'
  ]; // Example country codes

  // Regular expression for validating email format
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Regular expression for validating phone number format
  final RegExp phoneRegExp = RegExp(
    r'^[0-9]{10}$', // Simple validation for a 10-digit phone number
  );

  // Email validation function
  bool isValidEmail() {
    return emailRegExp.hasMatch(email.value);
  }

  // Password validation function
  bool isValidPassword() {
    return password.value.length >= 6;
  }

  // Check if password and confirm password match
  bool isPasswordMatching() {
    return password.value == confirmPassword.value;
  }

  // Phone number validation function
  bool isValidPhoneNumber() {
    return phoneRegExp.hasMatch(phoneNumber.value);
  }

  // Function to check if the phone number matches the selected country code format
  bool isPhoneNumberValidWithCountryCode() {
    // You can customize the regex for each country code if needed
    if (selectedCountryCode.value == '+1') {
      return phoneRegExp
          .hasMatch(phoneNumber.value); // Validate US phone number
    } else if (selectedCountryCode.value == '+44') {
      return phoneRegExp
          .hasMatch(phoneNumber.value); // Validate UK phone number
    } else if (selectedCountryCode.value == '+91') {
      return phoneRegExp
          .hasMatch(phoneNumber.value); // Validate India phone number
    }
    return false;
  }
}
