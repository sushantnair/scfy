import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartPage extends StatelessWidget {
  final String email;

  CartPage({required this.email});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cart.items.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(cart.items[index]['name']),
                    subtitle: Text('Price: ₹${cart.items[index]['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIconButton(
                          icon: Icons.remove,
                          onPressed: () {
                            cart.decreaseQuantity(index, context);
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${cart.items[index]['quantity']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        _buildIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            cart.addItem(cart.items[index], context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: ₹${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null
                  : () async {
                      await cart.placeOrder(context, email);
                      Navigator.pop(context);
                    },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build plus and minus buttons
  Widget _buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red, // Red background for the button
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white), // White icon color
        onPressed: onPressed,
      ),
    );
  }
}
