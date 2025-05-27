import 'DriverSideModel.dart';
import 'RideRequestModelForDriverApp.dart';

class RideInProgressModelForDriverApp {
  final String rideId;
  final DriverModelForDriverApp driver;
  final RideRequestModelForDriverApp rideRequest;
  final double fare;
  final String paymentMethod;
  final String status; 
  final DateTime startTime;

  RideInProgressModelForDriverApp({
    required this.rideId,
    required this.driver,
    required this.rideRequest,
    required this.fare,
    required this.paymentMethod,
    required this.status,
    required this.startTime,
  });
}
