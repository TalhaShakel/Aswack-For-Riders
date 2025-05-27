import 'package:flutter/material.dart';

import 'DriverSideModel.dart';
import 'RideRequestModelForDriverApp.dart';

class DriverDataHelperForDriverApp {
  static List<DriverModelForDriverApp> getSampleDrivers() {
    return [
      DriverModelForDriverApp(
        id: 'd001',
        name: 'Ali Khan',
        rating: 4.8,
        vehicleDetails: 'Toyota Corolla - White',
        imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
        phoneNumber: '123-456-7890',
        isAvailable: true,
      ),
      DriverModelForDriverApp(
        id: 'd002',
        name: 'Sara Ahmed',
        rating: 4.7,
        vehicleDetails: 'Honda Civic - Black',
        imageUrl: 'https://randomuser.me/api/portraits/women/21.jpg',
        phoneNumber: '234-567-8901',
        isAvailable: false,
      ),
    ];
  }

  static List<RideRequestModelForDriverApp> getSampleRideRequests() {
    return [
      RideRequestModelForDriverApp(
        id: 'r001',
        pickupLocation: '123 Main St',
        dropoffLocation: '456 Elm St',
        fareEstimate: 12.50,
        riderName: 'John Doe',
        riderContact: '123-456-7890',
      ),
      RideRequestModelForDriverApp(
        id: 'r002',
        pickupLocation: '789 Oak St',
        dropoffLocation: '101 Pine St',
        fareEstimate: 15.00,
        riderName: 'Jane Smith',
        riderContact: '234-567-8901',
      ),
    ];
  }
}
