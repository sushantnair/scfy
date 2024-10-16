import 'package:flutter/material.dart';

class MoneySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Payment Settings'),
              onTap: () {
                // Navigate to payment settings
              },
            ),
            // Add more sections for wallet, UPI, cash on delivery
            ListTile(
              title: Text('Wallet'),
              onTap: () {
                // Handle wallet settings
              },
            ),
            ListTile(
              title: Text('UPI'),
              onTap: () {
                // Handle UPI settings
              },
            ),
            ListTile(
              title: Text('Cash on Delivery'),
              onTap: () {
                // Handle cash on delivery settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
