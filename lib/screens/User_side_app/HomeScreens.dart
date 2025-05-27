import 'package:aswack_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/HomeController.dart';
import '../../../controllers/HomeController.dart';
import '../../../models/RideTypeModel.dart';
import '../../../models/VehicleSubcategoryModel.dart';
import '../../../models/DriverModel.dart';
import '../../../utils/Sampledata.dart';
import 'DriverListScreen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();

  HomeScreen({super.key}) {
    pickupController.addListener(() {
      controller.pickup.value = pickupController.text.trim();
    });
    dropoffController.addListener(() {
      controller.dropoff.value = dropoffController.text.trim();
    });
  }

  void showDriverListScreen() {
    var drivers = controller.driverMatches();
    Get.to(() => DriverListScreen(
          drivers: drivers,
          pickupLocation: controller.pickup.value,
          dropoffLocation: controller.dropoff.value,
        ));
  }

  Widget rideOption(RideType rideType) {
    return Obx(() {
      final isSelected = controller.selectedRideType.value == rideType;
      return GestureDetector(
        onTap: () {
          controller.selectedRideType.value = rideType;
          controller.selectedSubcategory.value = null;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.06,
          ),
          margin: EdgeInsets.symmetric(
            vertical: Get.height * 0.01,
            horizontal: Get.width * 0.04,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Constants.PRIMARY_COLOR : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected ? Constants.PRIMARY_COLOR : Colors.grey.shade400,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Constants.PRIMARY_COLOR.withOpacity(0.5),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(Icons.directions_car_outlined,
                  color: isSelected ? Colors.white : Constants.PRIMARY_COLOR),
              SizedBox(width: Get.width * 0.04),
              Text(
                rideType.title,
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget subcategoryOption(VehicleSubcategory subcat) {
    return GestureDetector(
      onTap: () {
        controller.selectedSubcategory.value = subcat;

        final driversAvailable = controller.areDriversAvailable;

        Get.dialog(
          AlertDialog(
            title: Text('Fare & Driver Availability',
                style: TextStyle(color: Constants.PRIMARY_COLOR)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Estimated Fare: \$${subcat.fareEstimate.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text(
                  driversAvailable
                      ? 'Drivers are available.'
                      : 'No drivers available for this vehicle.',
                  style: TextStyle(
                      color: driversAvailable ? Colors.green : Colors.red),
                ),
              ],
            ),
            actions: [
              if (driversAvailable)
                TextButton(
                  onPressed: () {
                    Get.back(); // close fare popup
                    showDriverListScreen(); // navigate to drivers list screen
                  },
                  child: Text('Confirm Ride',
                      style: TextStyle(color: Constants.PRIMARY_COLOR)),
                ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Close',
                    style: TextStyle(color: Constants.PRIMARY_COLOR)),
              ),
            ],
          ),
          barrierDismissible: true,
        );
      },
      child: Obx(() {
        final isSelected = controller.selectedSubcategory.value == subcat;
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.015,
            horizontal: Get.width * 0.05,
          ),
          margin: EdgeInsets.symmetric(
            vertical: Get.height * 0.007,
            horizontal: Get.width * 0.02,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Constants.PRIMARY_COLOR
                : Constants.PRIMARY_COLOR.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.white70,
              width: 1.5,
            ),
          ),
          child: Text(
            subcat.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }),
    );
  }

  Widget selectedLocationRow(
      String label, String location, VoidCallback onEdit) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
        vertical: Get.height * 0.008,
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Constants.PRIMARY_COLOR),
          SizedBox(width: Get.width * 0.02),
          Expanded(
            child: Text(
              '$label: $location',
              style: TextStyle(
                fontSize: Get.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: onEdit,
            child:
                Text('Edit', style: TextStyle(color: Constants.PRIMARY_COLOR)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double mapHeight = Get.height * 0.3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(fontSize: Get.width * 0.05, color: Colors.white)),
        backgroundColor: Constants.PRIMARY_COLOR,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: mapHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage('assets/map_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Obx(() {
              if (!controller.isSelectingRide.value) {
                return Container(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: Get.width * 0.03,
                        offset: Offset(0, -3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Get.width * 0.06),
                      topRight: Radius.circular(Get.width * 0.06),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: pickupController,
                        decoration: InputDecoration(
                          labelText: 'Pickup Location',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.02),
                          ),
                          prefixIcon: Icon(Icons.my_location,
                              color: Constants.PRIMARY_COLOR),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        ),
                        style: TextStyle(fontSize: Get.width * 0.045),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      TextField(
                        controller: dropoffController,
                        decoration: InputDecoration(
                          labelText: 'Drop-off Location',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.02),
                          ),
                          prefixIcon: Icon(Icons.location_on,
                              color: Constants.PRIMARY_COLOR),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        ),
                        style: TextStyle(fontSize: Get.width * 0.045),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: Get.width * 0.03,
                        offset: Offset(0, -3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Get.width * 0.06),
                      topRight: Radius.circular(Get.width * 0.06),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      selectedLocationRow(
                        'Pickup',
                        controller.pickup.value,
                        () => controller.isSelectingRide.value = false,
                      ),
                      selectedLocationRow(
                        'Drop-off',
                        controller.dropoff.value,
                        () => controller.isSelectingRide.value = false,
                      ),
                      Divider(
                        thickness: 1,
                        indent: Get.width * 0.05,
                        endIndent: Get.width * 0.05,
                      ),
                      if (controller.selectedRideType.value != null) ...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Row(
                            children:
                                controller.selectedRideType.value!.subcategories
                                    .map((subcat) => Padding(
                                          padding: EdgeInsets.only(
                                              right: Get.width * 0.03),
                                          child: subcategoryOption(subcat),
                                        ))
                                    .toList(),
                          ),
                        ),
                      ],
                      ...rideTypes.map(rideOption),
                      SizedBox(height: Get.height * 0.015),
                    ],
                  ),
                );
              }
            }),
          ),
          Obx(() {
            if (controller.isFormValid && !controller.isSelectingRide.value) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(Get.width * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    controller.isSelectingRide.value = true;
                    controller.selectedRideType.value = null;
                    controller.selectedSubcategory.value = null;
                  },
                  child: Text(
                    'Select Ride',
                    style: TextStyle(
                        color: Colors.white, fontSize: Get.width * 0.045),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.PRIMARY_COLOR,
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.022),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.03),
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
