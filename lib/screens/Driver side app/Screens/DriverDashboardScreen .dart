import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'Driverride_details_screen.dart'; // Import RideDetailsScreen

class DriverDashboardScreen extends StatelessWidget {
  DriverDashboardScreen({Key? key}) : super(key: key);

  final RxBool isAvailable = true.obs; // To toggle availability
  final RxList<String> rideRequests = [
    'Pickup: 123 Main St, Drop-off: 456 Elm St',
    'Pickup: 789 Oak St, Drop-off: 101 Pine St'
  ].obs; // Dummy ride requests

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Available/Offline
            Obx(() => Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      'Available for rides',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    value: isAvailable.value,
                    onChanged: (bool value) {
                      isAvailable.value = value;
                    },
                  ),
                )),
            SizedBox(height: 20),

            // Ride Requests Section Header
            Text(
              'Ride Requests:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.PRIMARY_COLOR),
            ),
            SizedBox(height: 10),

            // Ride Requests List
            Expanded(
              child: ListView.builder(
                itemCount: rideRequests.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      title: Text(
                        rideRequests[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Constants.PRIMARY_COLOR,
                      ),
                      onTap: () {
                        // Navigate to RideDetailsScreen when tapping on a ride request
                        Get.to(() => DriverRideDetailsScreen(
                            rideDetails: rideRequests[index]));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
