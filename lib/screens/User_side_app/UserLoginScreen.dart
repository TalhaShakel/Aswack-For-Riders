import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aswack_ride/screens/User_side_app/HomeScreens.dart';
import 'package:aswack_ride/screens/User_side_app/Usersign-up%20screen.dart';
import '../../utils/constants.dart';
import 'Controller/user_controller.dart'; // Import UserController

class UserLoginScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
        backgroundColor: Constants.PRIMARY_COLOR,
        title: Text(
          "Sign In",
          style: TextStyle(
            fontSize:
                screenWidth * 0.065, // Adjust font size based on screen width
            fontWeight: FontWeight.bold,
            color: Colors.white, // White title text color
          ),
        ),
        centerTitle: true, // Center the title
        elevation: 0, // Remove the shadow
      ),
      body: SingleChildScrollView(
        // To make the body scrollable if keyboard is open
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Email input with validation
            Obx(() {
              return TextFormField(
                controller: userController.emailController,
                onChanged: (value) {
                  userController.email.value = value;
                  userController.emailError.value = ''; // Clear error message
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: userController.emailError.isEmpty
                      ? null
                      : userController.emailError.value,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                ),
              );
            }),
            SizedBox(height: screenHeight * 0.02), // Adjust spacing dynamically

            // Password input with validation and show/hide functionality
            Obx(() {
              return TextFormField(
                controller: userController.passwordController,
                obscureText: userController
                    .obscurePassword.value, // Bind to reactive variable
                onChanged: (value) {
                  userController.password.value = value;
                  userController.passwordError.value =
                      ''; // Clear error message
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: userController.passwordError.isEmpty
                      ? null
                      : userController.passwordError.value,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      userController.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      userController.obscurePassword.value = !userController
                          .obscurePassword.value; // Toggle visibility
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: screenHeight * 0.03), // Adjust spacing dynamically

            // Sign-In button
            ElevatedButton(
              onPressed: () {
                if (!userController.isValidEmail()) {
                  userController.emailError.value =
                      'Please enter a valid email address';
                } else if (!userController.isValidPassword()) {
                  userController.passwordError.value =
                      'Password must be at least 6 characters';
                } else {
                  // If valid, proceed with sign-in
                  if (userController.email.value == 'test@example.com' &&
                      userController.password.value == 'password123') {
                    Get.to(HomeScreen()); // Navigate using GetX
                  } else {
                    // Show an error message for invalid credentials
                    Get.defaultDialog(
                      title: 'Error',
                      middleText: 'Invalid credentials, please try again.',
                    );
                  }
                }
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontSize: screenWidth * 0.04), // Adjust button text size
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Constants.PRIMARY_COLOR, // White text color on the button
                padding: EdgeInsets.symmetric(
                    vertical: 16, horizontal: screenWidth * 0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02), // Adjust spacing dynamically

            // Sign Up button (navigate to Sign Up screen)
            TextButton(
              onPressed: () {
                Get.to(UserSignUpScreen()); // Navigate using GetX
              },
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(
                    fontSize: screenWidth *
                        0.04), // Adjust font size based on screen size
              ),
              style: TextButton.styleFrom(
                foregroundColor: Constants.PRIMARY_COLOR,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
