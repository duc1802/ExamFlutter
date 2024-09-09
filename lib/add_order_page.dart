// lib/add_order_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddOrderPage extends StatelessWidget {
  final TextEditingController _dishNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final FirebaseFirestore _database = FirebaseFirestore.instance;

  void _addOrder(BuildContext context) {
    final String dishName = _dishNameController.text;
    final String notes = _notesController.text;
    final int quantity = int.tryParse(_quantityController.text) ?? 1;

    if (dishName.isNotEmpty) {
      _database.collection('orders').add({
        'dishName': dishName,
        'notes': notes,
        'quantity': quantity,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order added successfully!')),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add order: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dishNameController,
              decoration: InputDecoration(labelText: 'Dish name'),
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _addOrder(context),
                  child: Text('Add Item'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _dishNameController.clear();
                    _notesController.clear();
                    _quantityController.clear();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
