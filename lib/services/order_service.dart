import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import 'appwrite_service.dart';

class OrderService extends ChangeNotifier {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => List.unmodifiable(_orders);

  final AppwriteService _appwrite = AppwriteService();

  // Initialize and subscribe to real-time updates
  void init() {
    _appwrite.init();
    _fetchOrders();
    _subscribeToOrders();
  }

  Future<void> _fetchOrders() async {
    final docs = await _appwrite.getPendingOrders();
    _orders = docs.map((doc) => OrderModel.fromDocument(doc)).toList();
    notifyListeners();
  }

  void _subscribeToOrders() {
    _appwrite.subscribeToOrders().listen((event) {
      print("Realtime update: ${event.events}");

      // If a new document is created
      if (event.events.any((e) => e.endsWith('.create'))) {
        final newOrder = OrderModel.fromJson(event.payload);
        _orders.insert(0, newOrder);
        notifyListeners();
      }

      // If a document is updated
      if (event.events.any((e) => e.endsWith('.update'))) {
        // Re-fetch or update locally
        _fetchOrders();
      }
    });
  }

  // Create a new order (Called from Mobile App)
  Future<void> createOrder(OrderModel order) async {
    // Optimistic UI update (optional, but good for UX)
    // _orders.insert(0, order);
    // notifyListeners();

    await _appwrite.createOrder(order.toJson());
  }
}
