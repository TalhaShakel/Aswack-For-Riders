class RideRequestModelForDriverApp {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final double fareEstimate;
  final String riderName;
  final String riderContact;

  RideRequestModelForDriverApp({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.fareEstimate,
    required this.riderName,
    required this.riderContact,
  });
}
