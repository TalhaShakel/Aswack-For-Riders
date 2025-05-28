import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../utils/constants.dart';
import '../widgets/DriverRideRequestCard.dart';
import 'Driverride_details_screen.dart';
import 'package:intl/intl.dart';

import 'driver_drawer.dart';

class DriverDashboardScreen extends StatefulWidget {
  DriverDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  final RxBool isAvailable = true.obs;
  final RxBool showEarnings = true.obs;
  final RxDouble totalEarnings = 256.75.obs;

  final RxList<String> rideRequests = [
    'Pickup: 123 Main St, Drop-off: 456 Elm St',
    'Pickup: 789 Oak St, Drop-off: 101 Pine St',
    'Pickup: 202 Maple Ave, Drop-off: 303 Birch Blvd',
    'Pickup: 1010 Cedar Rd, Drop-off: 2020 Oak Ln',
  ].obs;

  final Map<int, bool> _visibleItems = {};
  final String driverProfileImageUrl =
      'https://randomuser.me/api/portraits/men/11.jpg';

  final String driverName = 'James';

  @override
  void initState() {
    super.initState();
    _initVisibility();
  }

  void _initVisibility() {
    for (int i = 0; i < rideRequests.length; i++) {
      _visibleItems[i] = false;
      Future.delayed(Duration(milliseconds: 150 * i), () {
        if (mounted) {
          setState(() {
            _visibleItems[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      drawer: DriverDrawer(
        driverName: driverName,
        driverProfileImageUrl: driverProfileImageUrl,
      ),
      appBar: AppBar(
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
        leadingWidth: 80,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(driverProfileImageUrl),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ),
        title: Text(
          'Driver Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Get.snackbar('Notifications', 'No new notifications',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and Greeting
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Constants.PRIMARY_COLOR,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Hello $driverName 👋',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),

              // Availability toggle
              Obx(
                () => Card(
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
                    onChanged: (val) => isAvailable.value = val,
                    activeColor: Constants.PRIMARY_COLOR,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Earnings Box
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Constants.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.PRIMARY_COLOR.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Earnings',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6),
                          Obx(() => Text(
                                showEarnings.value
                                    ? '\$${totalEarnings.value.toStringAsFixed(2)}'
                                    : '******',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              )),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            showEarnings.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () =>
                              showEarnings.value = !showEarnings.value,
                          tooltip: showEarnings.value
                              ? 'Hide earnings'
                              : 'Show earnings',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28),

              // Ride Requests Header
              Text(
                'Ride Requests',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Constants.PRIMARY_COLOR),
              ),
              SizedBox(height: 12),

              // Now a fixed height container with scrollable list
              Container(
                height: 400, // adjust as needed or calculate dynamically
                child: Obx(
                  () => ListView.builder(
                    physics:
                        ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: rideRequests.length,
                    itemBuilder: (context, index) {
                      final request = rideRequests[index];
                      final parts = request.split(', ');
                      final pickup = parts.length > 0
                          ? parts[0].replaceFirst('Pickup: ', '')
                          : '';
                      final dropoff = parts.length > 1
                          ? parts[1].replaceFirst('Drop-off: ', '')
                          : '';

                      return AnimatedOpacity(
                        opacity: _visibleItems[index] == true ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        child: RideRequestCard(
                          fare: 23,
                          pickupLocation: pickup,
                          dropoffLocation: dropoff,
                          userName: 'John Doe',
                          userImageUrl:
                              'https://randomuser.me/api/portraits/men/1.jpg',
                          onAccept: () {
                            Get.to(() => DriverRideDetailsScreen(
                                rideDetails: rideRequests[index]));
                            print('Ride accepted');
                          },
                          onDecline: () {
                            print('Ride declined');
                          },
                          onCall: () {
                            print('Call initiated');
                          },
                          onChat: () {
                            print('Chat opened');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
