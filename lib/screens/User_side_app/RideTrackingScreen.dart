import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';

class DriverRideDetailsScreen extends StatelessWidget {
  final String rideDetails;

  DriverRideDetailsScreen({required this.rideDetails});

  @override
  Widget build(BuildContext context) {
    final parts = rideDetails.split(', ');
    final pickup =
        parts.length > 0 ? parts[0].replaceFirst('Pickup: ', '') : '';
    final dropoff =
        parts.length > 1 ? parts[1].replaceFirst('Drop-off: ', '') : '';
    final riderName = "John Doe";
    final fare = "₹350";
    final distance = "7.5 km";
    final duration = "15 mins";
    final rideId = "#RID123456";
    final status = "Awaiting Pickup";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Ride Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRideInfoCard(rideId, status),
            SizedBox(height: 16),
            _buildInfoCard(Icons.person, 'Rider', riderName),
            _buildInfoCard(Icons.attach_money, 'Estimated Fare', fare),
            _buildInfoCard(
                Icons.timer, 'Distance & Duration', '$distance • $duration'),
            _buildInfoCard(Icons.my_location, 'Pickup Location', pickup),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/map_placeholder.png',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            _buildInfoCard(Icons.location_on, 'Drop-off Location', dropoff),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Get.snackbar('Ride Started', 'You have started the ride.',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text('Start Ride', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideInfoCard(String rideId, String status) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Ride ID: $rideId',
              style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                  color: Colors.orange[900], fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Constants.PRIMARY_COLOR, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                SizedBox(height: 4),
                Text(value,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
