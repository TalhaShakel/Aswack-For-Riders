import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'DriverDashboardScreen.dart';

class DriverTripSummaryScreen extends StatefulWidget {
  final String fare;
  final String distance;
  final String duration;
  final String paymentMethod;

  const DriverTripSummaryScreen({
    Key? key,
    required this.fare,
    required this.distance,
    required this.duration,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  _DriverTripSummaryScreenState createState() =>
      _DriverTripSummaryScreenState();
}

class _DriverTripSummaryScreenState extends State<DriverTripSummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _fadeInAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool?> _showConfirmDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text('Are you sure the payment is confirmed?'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Confirm', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Summary', style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[100],
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard("Fare", widget.fare),
              _buildSummaryCard("Distance", widget.distance),
              _buildSummaryCard("Duration", widget.duration),
              _buildSummaryCard("Payment Method", widget.paymentMethod),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final confirmed = await _showConfirmDialog();
                  if (confirmed == true) {
                    Get.snackbar(
                      "Payment Confirmed",
                      "Trip completed successfully.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Get.offAll(() => DriverDashboardScreen());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.PRIMARY_COLOR,
                  foregroundColor: Colors.white, // white text
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black45,
                ),
                child: Text("Confirm Payment",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Constants.PRIMARY_COLOR)),
        ],
      ),
    );
  }
}
