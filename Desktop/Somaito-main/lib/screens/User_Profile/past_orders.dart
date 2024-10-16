import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class PastOrdersPage extends StatefulWidget {
  final String email;

  PastOrdersPage({required this.email});
  
  @override
  _PastOrdersPageState createState() => _PastOrdersPageState(email: email);
}

class _PastOrdersPageState extends State<PastOrdersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, List<Map<String, dynamic>>> groupedOrders = {};
  bool _isLoading = true;

  final String email;

  _PastOrdersPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _fetchPastOrders();
  }

  Future<void> _fetchPastOrders() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('user_email', isEqualTo: email) // Fetch only the orders of the current user
          .orderBy('timestamp', descending: true) // Sort by timestamp in descending order
          .get();

      setState(() {
        // Group the orders by date
        for (var doc in snapshot.docs) {
          Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
          String formattedDate = _formatDate(orderData['timestamp']); // Format date as '26 Oct 2024'

          if (!groupedOrders.containsKey(formattedDate)) {
            groupedOrders[formattedDate] = [];
          }
          groupedOrders[formattedDate]!.add(orderData);
        }

        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching past orders: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('d MMM yyyy').format(date); // Format date as '26 Oct 2024'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : groupedOrders.isEmpty
              ? Center(child: Text('No past orders available'))
              : ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: groupedOrders.keys.length,
                  itemBuilder: (context, index) {
                    final dateKey = groupedOrders.keys.elementAt(index);
                    final ordersForDate = groupedOrders[dateKey]!;

                    // Calculate total price for this date
                    double totalPriceForDate = ordersForDate.fold(
                        0.0, (sum, order) => sum + (order['totalPrice'] as double));

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Date heading with red background and white font, left-aligned
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              dateKey,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left, // Left-aligned text
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display all orders for this date
                                  ...ordersForDate.map((order) {
                                    final items = List<String>.from(order['items']);
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ...items.map((item) => Row(
                                              children: [
                                                Icon(Icons.fastfood, color: Colors.grey), // Food icon
                                                SizedBox(width: 8),
                                                Text(item),
                                              ],
                                            )).toList(),
                                        SizedBox(height: 4),
                                      ],
                                    );
                                  }).toList(),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ),
                          // Total Price with red background and white font at the bottom
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Total : ₹${totalPriceForDate.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right, // Right-aligned text
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
