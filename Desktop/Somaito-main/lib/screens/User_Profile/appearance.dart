import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somato/models/theme_model.dart';


class AppearanceSettings extends StatefulWidget {
  @override
  _AppearanceSettingsState createState() => _AppearanceSettingsState();
}

class _AppearanceSettingsState extends State<AppearanceSettings> {
  @override
  Widget build(BuildContext context) {
    // Access the ThemeModel from Provider
    final themeModel = Provider.of<ThemeModel>(context);
    String _selectedTheme = themeModel.isDark ? 'Dark' : 'Light';

    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Light Theme'),
              leading: Radio<String>(
                value: 'Light',
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value!;
                    if (_selectedTheme == 'Light') {
                      // If the current theme is dark, toggle it to light
                      if (themeModel.isDark) {
                        themeModel.toggleTheme();
                      }
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Dark Theme'),
              leading: Radio<String>(
                value: 'Dark',
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value!;
                    if (_selectedTheme == 'Dark') {
                      // If the current theme is light, toggle it to dark
                      if (!themeModel.isDark) {
                        themeModel.toggleTheme();
                      }
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save selected theme preferences
                Navigator.pop(context);
              },
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
