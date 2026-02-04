import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import 'supabase_service.dart';

class OrderService extends ChangeNotifier {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => List.unmodifiable(_orders);

  final SupabaseService _supabase = SupabaseService();

  // Initialize and subscribe to real-time updates
  void init() {
    _subscribeToOrders();
  }

  void _subscribeToOrders() {
    _supabase.subscribeToOrders().listen((data) {
      print("Supabase update: Received ${data.length} orders");
      _orders = data.map((json) => OrderModel.fromJson(json)).toList();
      notifyListeners();
    });
  }

  // Create a new order (Called from Mobile App or POS)
  Future<void> createOrder(OrderModel order) async {
    try {
      await _supabase.createOrder(order.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
