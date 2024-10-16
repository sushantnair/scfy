import 'package:flutter/material.dart';

class AdvancedSearchPage extends StatefulWidget {
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  RangeValues _priceRange = RangeValues(0, 100);
  String _selectedCuisine = 'All';
  bool _isVegetarian = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for dishes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Price Range'),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                '\$${_priceRange.start.round()}',
                '\$${_priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Cuisine'),
            DropdownButton<String>(
              value: _selectedCuisine,
              isExpanded: true,
              items: <String>['All', 'Indian', 'Chinese', 'Italian', 'Mexican']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCuisine = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isVegetarian,
                  onChanged: (bool? value) {
                    setState(() {
                      _isVegetarian = value!;
                    });
                  },
                ),
                Text('Vegetarian Only'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Search'),
              onPressed: () {
                // TODO: Implement search functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}