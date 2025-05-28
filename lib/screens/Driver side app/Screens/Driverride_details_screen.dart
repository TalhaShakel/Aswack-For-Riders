import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'DriverTripSummaryScreen.dart';

class DriverRideDetailsScreen extends StatefulWidget {
  final String rideDetails;

  DriverRideDetailsScreen({required this.rideDetails});

  @override
  _DriverRideDetailsScreenState createState() =>
      _DriverRideDetailsScreenState();
}

class _DriverRideDetailsScreenState extends State<DriverRideDetailsScreen> {
  int rideStage = 0; // 0: To pickup, 1: Arrived, 2: Ride started, 3: Ride ended

  @override
  Widget build(BuildContext context) {
    final parts = widget.rideDetails.split(', ');
    final pickup =
        parts.length > 0 ? parts[0].replaceFirst('Pickup: ', '') : '';
    final dropoff =
        parts.length > 1 ? parts[1].replaceFirst('Drop-off: ', '') : '';
    final riderName = "John Doe";
    final fare = "₹350";
    final distance = "7.5 km";
    final duration = "15 mins";
    final rideId = "#RID123456";
    final paymentMethod = "UPI";
    final statusList = [
      "Awaiting Acceptance", // -1
      "Navigating to Pickup", // 0
      "Arrived at Pickup", // 1
      "Trip in Progress", // 2
      "Trip Completed" // 3
    ];

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
            _buildRideInfoCard(rideId, statusList[rideStage]),
            SizedBox(height: 16),
            _buildInfoCard(Icons.person, 'Rider', riderName),
            _buildInfoCard(Icons.attach_money, 'Estimated Fare', fare),
            _buildInfoCard(Icons.payment, 'Payment Method', paymentMethod),
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
            _buildRideStageButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRideStageButton() {
    String buttonText;
    VoidCallback? onPressed;

    switch (rideStage) {
      case 0:
        buttonText = "Accept Ride";
        onPressed = () {
          setState(() => rideStage = 1);
          _showTopPopup('Ride Accepted', 'You have accepted the ride.');
        };
        break;
      case 1:
        buttonText = "Arrived at Pickup";
        onPressed = () {
          setState(() => rideStage = 2);
          _showTopPopup('Arrived', 'You have reached the pickup location.');
        };
        break;
      case 2:
        buttonText = "Start Trip";
        onPressed = () {
          setState(() => rideStage = 3);
          _showTopPopup('Trip Started', 'Navigation to drop-off started.');
        };
        break;
      case 3:
        buttonText = "End Trip";
        onPressed = () {
          setState(() => rideStage = 4);
          _showTopPopup('Trip Completed', 'The ride has been completed.');
          Future.delayed(Duration(milliseconds: 500), () {
            Get.to(() => DriverTripSummaryScreen(
                  fare: "₹350",
                  distance: "7.5 km",
                  duration: "15 mins",
                  paymentMethod: "UPI",
                ));
          });
        };
        break;
      default:
        buttonText = "Trip Completed";
        onPressed = null;
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText, style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.PRIMARY_COLOR,
        foregroundColor: Colors.white, // 👈 This makes the text color white
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildRideInfoCard(String rideId, String status) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey(status),
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
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
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

  void _showTopPopup(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0), // distance from top
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Constants.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(message,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
