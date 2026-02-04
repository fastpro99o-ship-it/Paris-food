import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // CONSTANTS - REPLACE WITH YOUR VALUES
  static const String supabaseUrl = 'https://pdsppxtaisslrfppnyli.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkc3BweHRhaXNzbHJmcHBueWxpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAyMTUxNTEsImV4cCI6MjA4NTc5MTE1MX0._WXqIhkZwjJ2c5yYRk-a2mF9crokvIigWW1JiHRocOk';

  static Future<void> init() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  SupabaseClient get client => Supabase.instance.client;

  Future<void> createOrder(Map<String, dynamic> data) async {
    try {
      await client.from('orders').insert(data);
    } catch (e) {
      print("Supabase Insert Error: $e");
      rethrow; // Important: rethrow so the UI can catch it
    }
  }

  Future<List<Map<String, dynamic>>> getPendingOrders() async {
    try {
      final data = await client
          .from('orders')
          .select()
          .eq('status', 'pending')
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print("Error getting orders: $e");
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> subscribeToOrders() {
    return client
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('status', 'pending')
        .order('created_at', ascending: false);
  }
}
