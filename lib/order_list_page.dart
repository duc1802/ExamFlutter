
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_order_page.dart';
import 'order_model.dart' as custom; // Đặt alias là "custom" cho file order_model.dart

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  // Đổi tên class Order từ order_model.dart thành custom.Order
  Stream<List<custom.Order>> readOrders() {
    return _database.collection('orders').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => custom.Order.fromMap(doc.data(), doc.id)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddOrderPage()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<custom.Order>>( // Đổi tên class Order thành custom.Order
        stream: readOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text(order.dishName),
                  subtitle: Text(order.notes),
                  trailing: Text(order.quantity.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}