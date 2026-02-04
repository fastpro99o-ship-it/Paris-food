import 'dart:convert';
import 'package:appwrite/models.dart';
import 'cart_item.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime timestamp;
  final String tableNumber;
  String status; // 'pending', 'cooking', 'ready', 'paid'

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.timestamp,
    required this.tableNumber,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': jsonEncode(items.map((i) => i.toJson()).toList()),
      'total': total,
      'timestamp': timestamp.toIso8601String(),
      'table_number': tableNumber,
      'status': status,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var itemsList = <CartItem>[];
    if (json['items'] != null) {
      try {
        // Handle both string (from DB) and List (local) if needed
        var itemsJson = json['items'] is String
            ? jsonDecode(json['items'])
            : json['items'];

        if (itemsJson is List) {
          itemsList = itemsJson.map((i) => CartItem.fromJson(i)).toList();
        }
      } catch (e) {
        print("Error parsing items: $e");
      }
    }

    return OrderModel(
      id: json['\$id'] ?? '', // Appwrite ID
      items: itemsList,
      total: (json['total'] ?? 0.0).toDouble(),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      tableNumber: json['table_number'] ?? 'Unknown',
      status: json['status'] ?? 'pending',
    );
  }

  factory OrderModel.fromDocument(Document doc) {
    final data = doc.data;
    data['\$id'] = doc.$id;
    return OrderModel.fromJson(data);
  }
}
