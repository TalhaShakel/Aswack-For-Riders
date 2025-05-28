import 'package:aswack_ride/screens/Driver%20side%20app/Screens/Driverride_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'DriverRideHistoryDetailsPage.dart';

class DriverRideHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> rideHistory;

  const DriverRideHistoryScreen({Key? key, required this.rideHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white), // white back icon
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: rideHistory.length,
        itemBuilder: (context, index) {
          final ride = rideHistory[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              title: Text(
                '${ride['pickup']} → ${ride['dropoff']}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  ride['date'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              trailing: Text(
                ride['fare'] ?? '',
                style: TextStyle(
                  color: Constants.PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // TODO: Show ride details page
                Get.to(
                  () => DriverRideHistoryDetailsPage(
                    rideId: '#RID123456',
                    riderName: 'John Doe',
                    pickupLocation: '123 Main St',
                    dropoffLocation: '456 Elm St',
                    date: 'May 21, 2024',
                    fare: '₹250',
                    duration: '20 mins',
                    paymentMethod: 'UPI',
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          );
        },
      ),
    );
  }
}
