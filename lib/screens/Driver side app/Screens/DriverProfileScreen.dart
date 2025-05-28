import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import 'DriverEditProfileScreen.dart';

class DriverProfileScreen extends StatelessWidget {
  final String driverName;
  final String driverEmail;
  final String driverPhone;
  final String profileImageUrl;

  const DriverProfileScreen({
    Key? key,
    required this.driverName,
    required this.driverEmail,
    required this.driverPhone,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white), // White text
        ),
        iconTheme: IconThemeData(color: Colors.white), // White back icon
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profileImageUrl),
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            Text(driverName,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Constants.PRIMARY_COLOR)),
            SizedBox(height: 12),
            _buildInfoRow(Icons.email, 'Email', driverEmail),
            SizedBox(height: 10),
            _buildInfoRow(Icons.phone, 'Phone', driverPhone),
            SizedBox(height: 10),
            _buildInfoRow(Icons.directions_car, 'Vehicle',
                'Toyota Prius 2019'), // example
            SizedBox(height: 10),
            _buildInfoRow(Icons.badge, 'Driver ID', '#DR123456'), // example
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DriverEditProfileScreen(
                      name: driverName,
                      email: driverEmail,
                      phone: driverPhone,
                      profileImageUrl: profileImageUrl,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white, // White icon
              ),
              label: Text('Edit Profile',
                  style: TextStyle(
                      fontSize: 18, color: Colors.white)), // White text
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Constants.PRIMARY_COLOR, size: 24),
        SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              fontSize: 16),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
