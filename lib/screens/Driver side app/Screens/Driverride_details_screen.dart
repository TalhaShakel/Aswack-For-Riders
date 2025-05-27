import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart'; // Assuming this contains the primary color

class DriverRideDetailsScreen extends StatelessWidget {
  final String rideDetails;

  DriverRideDetailsScreen({required this.rideDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details', style: TextStyle(color: Colors.white)),
        backgroundColor:
            Constants.PRIMARY_COLOR, // Use primary color for app bar
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride details title
            Text(
              'Ride Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            SizedBox(height: 10),

            // Display the ride details
            Text(
              rideDetails,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Set text color to white
              ),
            ),
            Spacer(),

            // Start ride button
            ElevatedButton(
              onPressed: () {
                // Example: Start ride or some action
                Get.snackbar('Ride Started', 'You have started the ride.');
              },
              child: Text('Start Ride'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Constants.PRIMARY_COLOR, // Use primary color for button
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
