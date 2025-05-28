import 'package:aswack_ride/screens/User_side_app/role_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'DriverEarningsScreen.dart';
import 'DriverHelpScreen.dart';
import 'DriverProfileScreen.dart';
import 'DriverRideHistoryScreen.dart';

class DriverDrawer extends StatelessWidget {
  final String driverName;
  final String driverProfileImageUrl;

  const DriverDrawer({
    Key? key,
    required this.driverName,
    required this.driverProfileImageUrl,
  }) : super(key: key);

  // Mock ride history data (replace with real data source)
  final List<Map<String, String>> rideHistory = const [
    {
      'date': '2024-05-21',
      'pickup': '123 Main St',
      'dropoff': '456 Elm St',
      'fare': '₹250',
    },
    {
      'date': '2024-05-20',
      'pickup': '789 Oak St',
      'dropoff': '101 Pine St',
      'fare': '₹320',
    },
    {
      'date': '2024-05-18',
      'pickup': '202 Maple Ave',
      'dropoff': '303 Birch Blvd',
      'fare': '₹150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Constants.PRIMARY_COLOR.withOpacity(0.9),
                    Constants.PRIMARY_COLOR,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(driverProfileImageUrl),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      driverName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(context, Icons.person, 'Profile', () {
                    Navigator.of(context).pop(); // Close drawer first
                    Get.to(() => DriverProfileScreen(
                          driverName: driverName,
                          driverEmail: 'driver@example.com', // Pass real data
                          driverPhone: '+1234567890',
                          profileImageUrl: driverProfileImageUrl,
                        ));
                  }),
                  _buildDrawerItem(context, Icons.monetization_on, 'Earnings',
                      () {
                    Navigator.of(context).pop();
                    Get.to(() => DriverEarningsScreen(
                          totalEarnings: 1200.00,
                          earningsByMonth: {
                            'January': 200,
                            'February': 350,
                            'March': 650,
                          },
                        ));
                  }),
                  _buildDrawerItem(context, Icons.history, 'Ride History', () {
                    Navigator.of(context).pop();
                    Get.to(() =>
                        DriverRideHistoryScreen(rideHistory: rideHistory));
                  }),
                  _buildDrawerItem(context, Icons.help_outline, 'Help', () {
                    Navigator.of(context).pop();
                    Get.to(() => DriverHelpScreen());
                  }),
                  Divider(thickness: 1, indent: 16, endIndent: 16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Recent Rides',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Constants.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  ...rideHistory
                      .map((ride) => _buildRideHistoryItem(context, ride))
                      .toList(),
                  Divider(thickness: 1, indent: 16, endIndent: 16),
                  _buildDrawerItem(context, Icons.logout, 'Logout', () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(), // Close dialog
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              Navigator.of(context).pop(); // Close drawer
                              // TODO: Implement logout logic here (clear session, etc)
                              Get.offAll(() =>
                                  RoleSelection()); // Navigate to login screen
                            },
                            child: Text('Logout',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Constants.PRIMARY_COLOR),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
      horizontalTitleGap: 0,
      hoverColor: Constants.PRIMARY_COLOR.withOpacity(0.1),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildRideHistoryItem(BuildContext context, Map<String, String> ride) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text('${ride['pickup']} → ${ride['dropoff']}',
          style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle:
          Text(ride['date'] ?? '', style: TextStyle(color: Colors.grey[600])),
      trailing: Text(ride['fare'] ?? '',
          style: TextStyle(
              color: Constants.PRIMARY_COLOR, fontWeight: FontWeight.bold)),
      onTap: () {
        // TODO: Navigate to detailed ride info screen if needed
      },
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: Constants.PRIMARY_COLOR.withOpacity(0.1),
    );
  }
}
