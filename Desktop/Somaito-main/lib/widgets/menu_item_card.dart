import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class MenuItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  MenuItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    // Use null-aware operators to handle missing data
    final String name = item['name'] ?? 'Unnamed Item';  // Provide a default name
    final String image = item['image'] ?? 'assets/images/default_image.jpg';  // Provide a default image
    final double price = item['price'] != null ? item['price'].toDouble() : 0.0;  // Default price

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,  // Use the default image if null
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,  // Use the default name if null
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Price: ₹$price'),
                  Text('Estimated Time: 20'), // You may want to make this dynamic too
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add item to cart
                Provider.of<CartModel>(context, listen: false).addItem(item, context);
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
