// lib/order_model.dart
class Order {
  final String id;
  final String dishName;
  final String notes;
  final int quantity;

  Order({required this.id, required this.dishName, required this.notes, required this.quantity});

  // Chuyển dữ liệu từ Map thành Order object
  factory Order.fromMap(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      dishName: data['dishName'] ?? '',
      notes: data['notes'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }

  // Chuyển Order object thành Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'dishName': dishName,
      'notes': notes,
      'quantity': quantity,
    };
  }
}
