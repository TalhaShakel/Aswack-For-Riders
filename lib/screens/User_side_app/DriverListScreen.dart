import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/DriverModel.dart';
import '../../../utils/constants.dart';
import 'RideTrackingScreen.dart';

class DriverListScreen extends StatefulWidget {
  final List<DriverModel> drivers;
  final String pickupLocation;
  final String dropoffLocation;

  DriverListScreen({
    super.key,
    required this.drivers,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen>
    with SingleTickerProviderStateMixin {
  bool _loading = true;
  DriverModel? _selectedDriver;

  final RxString _paymentMethod = 'Cash'.obs;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _confirmRide() {
    if (_selectedDriver == null) {
      Get.snackbar('Error', 'Please select a driver first.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.defaultDialog(
      title: 'Confirm Ride',
      titleStyle: TextStyle(
          color: Constants.PRIMARY_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Driver: ${_selectedDriver!.name}',
              style: TextStyle(fontSize: 16)),
          Text('Fare: \$${_selectedDriver!.fare.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text('Pickup Location: ${widget.pickupLocation}',
              style: TextStyle(fontSize: 16)),
          Text('Drop-off Location: ${widget.dropoffLocation}',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text('Select Payment Method:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Obx(() => Column(
                children:
                    ['Cash', 'Credit Card', 'Mobile Wallet'].map((method) {
                  return RadioListTile<String>(
                    activeColor: Constants.PRIMARY_COLOR,
                    title: Text(method),
                    value: method,
                    groupValue: _paymentMethod.value,
                    onChanged: (value) {
                      if (value != null) _paymentMethod.value = value;
                    },
                  );
                }).toList(),
              )),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.to(() => DriverRideDetailsScreen(
                    rideDetails: "asda",
                    // driverName: _selectedDriver!.name,
                    // vehicleDetails: _selectedDriver!.vehicleDetails,
                    // fare: _selectedDriver!.fare,
                    // paymentMethod: _paymentMethod.value,
                    // driverImageUrl: _selectedDriver!.imageUrl,
                  ));
              // TODO: add ride start logic here
            },
            child: Text('Start Ride',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.PRIMARY_COLOR,
              minimumSize: Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
        title: Text('Finding Nearby Drivers',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? Center(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Constants.PRIMARY_COLOR),
                    SizedBox(height: 20),
                    Text(
                      'Finding drivers nearby...',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    itemCount: widget.drivers.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      final driver = widget.drivers[index];
                      final isSelected = _selectedDriver?.id == driver.id;
                      return Card(
                        elevation: isSelected ? 6 : 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: isSelected
                            ? Constants.PRIMARY_COLOR.withOpacity(0.9)
                            : Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(driver.imageUrl),
                            backgroundColor: Colors.grey[200],
                          ),
                          title: Text(
                            driver.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                'Rating: ${driver.rating.toStringAsFixed(1)} ⭐',
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.black54),
                              ),
                              Text(
                                'Vehicle: ${driver.vehicleDetails}',
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.black54),
                              ),
                              Text(
                                'Fare Estimate: \$${driver.fare.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.black54),
                              ),
                            ],
                          ),
                          trailing: isSelected
                              ? Icon(Icons.check_circle,
                                  color: Colors.white, size: 28)
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedDriver = driver;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ElevatedButton(
                    onPressed: _selectedDriver == null ? null : _confirmRide,
                    child: Text(
                      'Confirm Ride & Select Payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedDriver == null
                          ? Colors.grey
                          : Constants.PRIMARY_COLOR,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
