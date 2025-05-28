import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class DriverRideHistoryDetailsPage extends StatelessWidget {
  final String rideId;
  final String riderName;
  final String pickupLocation;
  final String dropoffLocation;
  final String date;
  final String fare;
  final String duration;
  final String paymentMethod;

  const DriverRideHistoryDetailsPage({
    Key? key,
    required this.rideId,
    required this.riderName,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.date,
    required this.fare,
    required this.duration,
    required this.paymentMethod,
  }) : super(key: key);

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Constants.PRIMARY_COLOR, size: 26),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 14)),
                SizedBox(height: 4),
                Text(value,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Ride History Details', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ride ID: $rideId',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Constants.PRIMARY_COLOR)),
            SizedBox(height: 20),
            _buildDetailRow(Icons.person, 'Rider', riderName),
            _buildDetailRow(Icons.calendar_today, 'Date', date),
            _buildDetailRow(
                Icons.my_location, 'Pickup Location', pickupLocation),
            _buildDetailRow(
                Icons.location_on, 'Drop-off Location', dropoffLocation),
            _buildDetailRow(Icons.timer, 'Duration', duration),
            _buildDetailRow(Icons.attach_money, 'Fare', fare),
            _buildDetailRow(Icons.payment, 'Payment Method', paymentMethod),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text('Back to History',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
