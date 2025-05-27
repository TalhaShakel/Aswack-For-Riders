import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/DriverModel.dart';
import '../models/RideTypeModel.dart';
import '../models/VehicleSubcategoryModel.dart';

// class HomeController extends GetxController {
//   var pickup = ''.obs;
//   var dropoff = ''.obs;

//   var isSelectingRide = false.obs;
//   var selectedRide = ''.obs;
//   var selectedSubcategory = ''.obs;

//   bool get isFormValid => pickup.isNotEmpty && dropoff.isNotEmpty;
//   bool get isRideSelected => selectedRide.isNotEmpty;
//   bool get isSubcategorySelected => selectedSubcategory.isNotEmpty;
// }

class HomeController extends GetxController {
  var pickup = ''.obs;
  var dropoff = ''.obs;

  var isSelectingRide = false.obs;
  var selectedRideType = Rxn<RideType>();
  var selectedSubcategory = Rxn<VehicleSubcategory>();

  bool get isFormValid => pickup.value.isNotEmpty && dropoff.value.isNotEmpty;
  bool get isSubcategorySelected => selectedSubcategory.value != null;

  // Return true if drivers exist for selected subcategory (simulate availability)
  bool get areDriversAvailable {
    final subcat = selectedSubcategory.value;
    return subcat != null && subcat.driver != null;
  }

  // Return list of drivers matching current selected ride type subcategory
  // For demo, returns single driver wrapped in list; adapt as needed.
  List<DriverModel> driverMatches() {
    if (selectedSubcategory.value == null) return [];

    // Return a list of matching drivers, e.g., in this example just the one driver wrapped in a list
    return [selectedSubcategory.value!.driver];
  }

  void resetSelection() {
    selectedRideType.value = null;
    selectedSubcategory.value = null;
    isSelectingRide.value = false;
  }
}
