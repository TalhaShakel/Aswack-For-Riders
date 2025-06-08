import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:aswack_ride/screens/User_side_app/UserLoginScreen.dart'; // Import the login screen
import '../../utils/constants.dart'; // Import Constants
import 'Controller/user_controller.dart';
import 'widgets/CountryCodeSelector.dart'; // Import UserController

class UserSignUpScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
        backgroundColor: Constants.PRIMARY_COLOR,
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White title text color
          ),
        ),
        centerTitle: true, // Center the title
        elevation: 0, // Remove the shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16),

            // Password input with validation and show/hide functionality
            Obx(() {
              return TextFormField(
                controller: userController.passwordController,
                obscureText: userController.obscurePassword.value,
                onChanged: (value) {
                  userController.password.value = value;
                  userController.passwordError.value = '';
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
                      userController.obscurePassword.value =
                          !userController.obscurePassword.value;
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 16),

            // Confirm Password input with validation and show/hide functionality
            Obx(() {
              return TextFormField(
                controller: userController.confirmPasswordController,
                obscureText: userController.obscureConfirmPassword.value,
                onChanged: (value) {
                  userController.confirmPassword.value = value;
                  userController.confirmPasswordError.value = '';
                },
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  errorText: userController.confirmPasswordError.isEmpty
                      ? null
                      : userController.confirmPasswordError.value,
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
                      userController.obscureConfirmPassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      userController.obscureConfirmPassword.value =
                          !userController.obscureConfirmPassword.value;
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 20),

            CountryCodeSelector(),

            // // Country code input with selection
            // Obx(() {
            //   return Column(
            //     children: [
            //       GestureDetector(
            //         onTap: () async {
            //           // Print the initial state of countries to check if data exists
            //           print(
            //               'Before sorting, countries: ${CountryManager().countries}');

            //           // Sort countries
            //           final sortedCountries = CountryManager().countries
            //             ..sort((a, b) => (a.countryName ?? '')
            //                 .compareTo(b.countryName ?? ''));

            //           // Print the sorted country list to check if sorting works correctly
            //           print('After sorting, countries: $sortedCountries');

            //           // Check if the country list is empty
            //           if (sortedCountries.isEmpty) {
            //             print('The country list is empty!');
            //           }

            //           final res =
            //               await showModalBottomSheet<CountryWithPhoneCode>(
            //             context: context,
            //             isScrollControlled: false,
            //             builder: (context) {
            //               return ListView.builder(
            //                 padding: const EdgeInsets.symmetric(vertical: 16),
            //                 itemBuilder: (context, index) {
            //                   final item = sortedCountries[index];
            //                   return GestureDetector(
            //                     behavior: HitTestBehavior.opaque,
            //                     onTap: () {
            //                       // Print the selected country data when tapped
            //                       print(
            //                           'Selected country: ${item.countryName}, Code: ${item.phoneCode}');
            //                       Navigator.of(context).pop(item);
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 24, vertical: 16),
            //                       child: Row(
            //                         children: [
            //                           Expanded(
            //                               child: Text('+${item.phoneCode}',
            //                                   textAlign: TextAlign.right)),
            //                           const SizedBox(width: 16),
            //                           Expanded(
            //                               flex: 8,
            //                               child: Text(item.countryName ?? '')),
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 },
            //                 itemCount: sortedCountries.length,
            //               );
            //             },
            //           );

            //           if (res != null) {
            //             // Print when a country is selected
            //             print(
            //                 'Country selected: ${res.countryName}, Code: ${res.phoneCode}');
            //             userController.selectedCountryCode.value =
            //                 res.phoneCode;
            //           } else {
            //             print('No country selected.');
            //           }
            //         },
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: Constants.PRIMARY_COLOR),
            //           ),
            //           child: Row(
            //             children: [
            //               Text(userController.selectedCountryCode.value),
            //               const Icon(Icons.arrow_drop_down),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 8),
            //     ],
            //   );
            // }),

            // // Phone Number input
            Obx(() {
              return TextFormField(
                controller: userController.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                  ),
                  errorText: userController.phoneError.isEmpty
                      ? null
                      : userController.phoneError.value,
                ),
                onChanged: (value) {
                  userController.phoneNumber.value = value;
                  userController.phoneError.value = '';
                },
              );
            }),
            SizedBox(height: 20),

            // Sign-Up button
            ElevatedButton(
              onPressed: () async {
                if (!userController.isValidEmail()) {
                  userController.emailError.value =
                      'Please enter a valid email address';
                } else if (!userController.isValidPassword()) {
                  userController.passwordError.value =
                      'Password must be at least 6 characters';
                } else if (!userController.isPasswordMatching()) {
                  userController.confirmPasswordError.value =
                      'Passwords do not match';
                } else if (!await userController
                    .isPhoneNumberValidWithCountryCode()) {
                  userController.phoneError.value =
                      'Please enter a valid phone number';
                } else {
                  // Proceed with sign-up
                  print("Sign Up successful!");
                  Get.to(UserLoginScreen());
                }
              },
              child: Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Sign In button (navigate to Sign In screen)
            TextButton(
              onPressed: () {
                Get.to(UserLoginScreen());
              },
              child: Text("Already have an account? Sign In"),
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
