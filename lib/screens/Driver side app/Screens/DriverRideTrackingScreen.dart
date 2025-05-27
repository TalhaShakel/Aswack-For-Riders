import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart'; // Assuming this contains the primary color

class DriverRideTrackingScreen extends StatelessWidget {
  final String driverName;
  final String vehicleDetails;
  final double fare;
  final String paymentMethod;
  final String driverImageUrl;

  DriverRideTrackingScreen({
    required this.driverName,
    required this.vehicleDetails,
    required this.fare,
    required this.paymentMethod,
    required this.driverImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride In Progress', style: TextStyle(color: Colors.white)),
        backgroundColor:
            Constants.PRIMARY_COLOR, // Use primary color for app bar
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Driver Image
              Container(
                width: Get.width * 0.3,
                height: Get.width * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(driverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.025),

              // Ride details
              Container(
                padding: EdgeInsets.all(Get.width * 0.05),
                margin: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                decoration: BoxDecoration(
                  color: Constants.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver: $driverName',
                      style: TextStyle(
                        fontSize: Get.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      'Vehicle: $vehicleDetails',
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.008),
                    Text(
                      'Fare: \$${fare.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.008),
                    Text(
                      'Payment Method: $paymentMethod',
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),

              // Tracking Section
              Text(
                'Tracking...',
                style: TextStyle(
                    fontSize: Get.width * 0.05, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: Get.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    size: Get.width * 0.25,
                    color: Constants.PRIMARY_COLOR,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),

              // Share Driver Details Button
              ElevatedButton(
                onPressed: () {
                  // Implement your share driver details logic
                },
                child: Text(
                  'Share Driver Details',
                  style: TextStyle(
                      fontSize: Get.width * 0.045, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.PRIMARY_COLOR,
                  minimumSize: Size(double.infinity, Get.height * 0.07),
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0, // Minimalistic design, no shadow
                ),
              ),
              SizedBox(height: Get.height * 0.015),

              // Custom Minimalistic End Ride Button
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Go back to previous screen (e.g., Home)
                },
                child: Text(
                  'End Ride',
                  style: TextStyle(
                      fontSize: Get.width * 0.045, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, Get.height * 0.07),
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0, // Minimalistic design, no shadow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
