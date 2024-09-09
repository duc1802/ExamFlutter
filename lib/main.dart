import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'order_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Khởi tạo Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Management App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: OrderListPage(), // Chuyển đến trang danh sách đơn hàng khi mở ứng dụng
    );
  }
}