import 'DriverModel.dart';

class VehicleSubcategory {
  final String name;
  final double fareEstimate;
  final DriverModel driver;

  VehicleSubcategory({
    required this.name,
    required this.fareEstimate,
    required this.driver,
  });
}
