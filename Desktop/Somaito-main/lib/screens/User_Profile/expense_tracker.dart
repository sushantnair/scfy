import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerPage extends StatefulWidget {
  final String email;

  ExpenseTrackerPage({required this.email});

  @override
  _ExpenseTrackerPageState createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> expenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('user_email', isEqualTo: widget.email) // Fetch only the orders of the current user
          .orderBy('timestamp', descending: true) // Ensure you have an index on user_email and timestamp
          .get();

      setState(() {
        expenses = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching expenses: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track your Expenses',
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : expenses.isEmpty
              ? Center(child: Text('No expenses available'))
              : ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final order = expenses[index];

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          'Expense on ${DateFormat('dd MMMM yyyy').format(order['timestamp'].toDate())}',
                          style: TextStyle(color: Colors.red), // Apply TextStyle here
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...order['items'].map<Widget>((item) {
                              return Text('${item}'); // Display each item
                            }).toList(),
                            SizedBox(height: 4),
                            Text('Total: ₹${order['totalPrice']}'), // Display total price
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
