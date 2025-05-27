import 'DriverSideModel.dart';
import 'RideRequestModelForDriverApp.dart';

class RideSummaryModelForDriverApp {
  final String rideId;
  final DriverModelForDriverApp driver;
  final RideRequestModelForDriverApp rideRequest;
  final double finalFare;
  final double rating;
  final String paymentMethod;
  final DateTime endTime;

  RideSummaryModelForDriverApp({
    required this.rideId,
    required this.driver,
    required this.rideRequest,
    required this.finalFare,
    required this.rating,
    required this.paymentMethod,
    required this.endTime,
  });
}
