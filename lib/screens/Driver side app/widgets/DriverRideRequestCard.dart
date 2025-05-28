import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class RideRequestCard extends StatelessWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final String userName;
  final String userImageUrl;
  final double fare;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  const RideRequestCard({
    Key? key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.userName,
    required this.userImageUrl,
    required this.fare,
    this.onAccept,
    this.onDecline,
    this.onCall,
    this.onChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Constants.PRIMARY_COLOR, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(userImageUrl),
                  backgroundColor: Colors.grey[200],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onCall,
                  icon: Icon(Icons.call, color: Constants.PRIMARY_COLOR),
                  tooltip: 'Call Rider',
                ),

                // Chat icon button
                IconButton(
                  onPressed: onChat,
                  icon: Icon(Icons.chat_bubble, color: Constants.PRIMARY_COLOR),
                  tooltip: 'Chat with Rider',
                ),
              ],
            ),
            SizedBox(height: 12),

            // Pickup and Dropoff
            Text(
              'Pickup: $pickupLocation',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              'Drop-off: $dropoffLocation',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 8),

            // Fare
            Text(
              'Fare: \$${fare.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Constants.PRIMARY_COLOR,
              ),
            ),
            SizedBox(height: 12),

            // Action buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Accept button
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // Decline button
                OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Constants.PRIMARY_COLOR,
                    side: BorderSide(color: Constants.PRIMARY_COLOR),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Decline'),
                ),

                // Call icon button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
