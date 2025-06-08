import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class DriverEarningsScreen extends StatelessWidget {
  final double totalEarnings;
  final Map<String, double> earningsByMonth;

  const DriverEarningsScreen({
    Key? key,
    required this.totalEarnings,
    required this.earningsByMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Earnings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Earnings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Constants.PRIMARY_COLOR,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: Constants.PRIMARY_COLOR.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Constants.PRIMARY_COLOR.withOpacity(0.2),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Text(
                '\$${totalEarnings.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Constants.PRIMARY_COLOR,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Monthly Earnings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                // ignore: deprecated_member_use
                color: Constants.PRIMARY_COLOR.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: earningsByMonth.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                  indent: 20,
                  endIndent: 20,
                ),
                itemBuilder: (context, index) {
                  final month = earningsByMonth.keys.elementAt(index);
                  final amount = earningsByMonth[month]!;
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      title: Text(
                        month,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        '\$${amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Constants.PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
