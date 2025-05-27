import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import '../../../utils/constants.dart';
import 'RideSummaryScreen .dart'; // Add this for sharing functionality

class RideTrackingScreen extends StatelessWidget {
  final String driverName;
  final String vehicleDetails;
  final double fare;
  final String paymentMethod;
  final String driverImageUrl; // New field for driver image

  RideTrackingScreen({
    required this.driverName,
    required this.vehicleDetails,
    required this.fare,
    required this.paymentMethod,
    required this.driverImageUrl,
  });

  Future<void> _shareDriverDetails() async {
    Get.defaultDialog(
      title: 'Coming Soon',
      middleText:
          'This sharing option will be available once we integrate backend functionality.',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = Get.width * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ride In Progress', style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Driver Image in circle with shadow
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(driverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.025),

              // Driver & Vehicle Details Container
              Container(
                padding: EdgeInsets.all(Get.width * 0.05),
                margin: EdgeInsets.symmetric(
                  vertical: Get.height * 0.015,
                  horizontal: 0,
                ),
                decoration: BoxDecoration(
                  color: Constants.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.blueGrey,
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: Offset(-5, -5),
                    ),
                  ],
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
                onPressed: _shareDriverDetails,
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
                  Get.defaultDialog(
                    title: 'End Ride',
                    middleText: 'Are you sure you want to end the ride?',
                    textConfirm: 'Yes',
                    textCancel: 'No',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back(); // Close dialog
                      // Navigate to ride summary screen
                      Get.to(() => RideSummaryScreen(
                            driverName: driverName,
                            vehicleDetails: vehicleDetails,
                            fare: fare,
                            paymentMethod: paymentMethod,
                            driverImageUrl: driverImageUrl,
                          ));
                    },
                  );
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
