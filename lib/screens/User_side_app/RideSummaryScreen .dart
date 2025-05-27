import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import 'HomeScreens.dart';

class RideSummaryScreen extends StatefulWidget {
  final String driverName;
  final String vehicleDetails;
  final double fare;
  final String paymentMethod;
  final String driverImageUrl;

  RideSummaryScreen({
    required this.driverName,
    required this.vehicleDetails,
    required this.fare,
    required this.paymentMethod,
    required this.driverImageUrl,
  });

  @override
  State<RideSummaryScreen> createState() => _RideSummaryScreenState();
}

class _RideSummaryScreenState extends State<RideSummaryScreen> {
  double _rating = 5.0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = Get.width * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Summary', style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Driver Image
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.driverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Thank you for riding with us!',
                style: TextStyle(
                    fontSize: Get.width * 0.05, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Ride details
              ListTile(
                title: Text('Driver'),
                subtitle: Text(widget.driverName),
              ),
              ListTile(
                title: Text('Vehicle'),
                subtitle: Text(widget.vehicleDetails),
              ),
              ListTile(
                title: Text('Fare'),
                subtitle: Text('\$${widget.fare.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: Text('Payment Method'),
                subtitle: Text(widget.paymentMethod),
              ),

              SizedBox(height: 30),

              // Rating bar
              Text('Rate your driver:', style: TextStyle(fontSize: 18)),
              Slider(
                value: _rating,
                min: 1,
                max: 5,
                divisions: 4,
                label: _rating.toStringAsFixed(1),
                onChanged: (val) {
                  setState(() {
                    _rating = val;
                  });
                },
              ),

              SizedBox(height: 20),

              // Feedback Text Field
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Write your feedback',
                  hintText: 'Share your experience...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),

              // Spacer(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Send rating, feedback, and ride completion info to backend here

                  // Access feedback text: _feedbackController.text

                  Get.snackbar(
                      'Thank You', 'Your ride has been completed successfully!',
                      snackPosition: SnackPosition.BOTTOM);

                  // Navigate back to home screen (clear navigation stack)
                  Get.offAll(() => HomeScreen());
                },
                child: Text('Complete Ride',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.PRIMARY_COLOR,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
