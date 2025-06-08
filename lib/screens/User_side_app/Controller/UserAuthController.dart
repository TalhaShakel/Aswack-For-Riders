import 'package:aswack_ride/screens/User_side_app/HomeScreens.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var userName = ''.obs;

  // Method to sign in the user
  void signIn() {
    // Here, we would typically check credentials against a backend or API
    if (email.value == 'test@example.com' && password.value == 'password123') {
      userName.value = 'John Doe'; // Assume this is the logged-in user's name
      print("Signed in as ${userName.value}");
      Get.to(() => HomeScreen()); // Navigate to HomePage
    } else {
      print("Invalid credentials");
      // Handle invalid login
    }
  }
}
