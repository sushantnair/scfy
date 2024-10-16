import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import 'payement_methods_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Profile'),
          ),
          body: ListView(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
              ),
              SizedBox(height: 20),
              Text(
                'John Doe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'john.doe@example.com',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile'),
                onTap: () {
                  // TODO: Implement edit profile functionality
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Delivery Addresses'),
                onTap: () {
                  // TODO: Implement delivery addresses page
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payment Methods'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {
                  // TODO: Implement notifications settings page
                },
              ),
              SwitchListTile(
                secondary: Icon(Icons.dark_mode),
                title: Text('Dark Mode'),
                value: themeModel.isDark,
                onChanged: (value) {
                  themeModel.toggleTheme();
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
                onTap: () {
                  // TODO: Implement help & support page
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  // TODO: Implement logout functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
