import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Credit/Debit Card'),
            trailing: Icon(Icons.add),
            onTap: () {
              // TODO: Implement add card functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('PayPal'),
            trailing: Icon(Icons.link),
            onTap: () {
              // TODO: Implement PayPal linking
            },
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Google Pay'),
            trailing: Icon(Icons.link),
            onTap: () {
              // TODO: Implement Google Pay linking
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Cash on Delivery'),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
        ],
      ),
    );
  }
}