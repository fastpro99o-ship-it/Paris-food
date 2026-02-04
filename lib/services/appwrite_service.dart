import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;
  AppwriteService._internal();

  late Client client;
  late Databases databases;
  late Account account;
  late Realtime realtime;

  // CONSTANTS - REPLACE WITH YOUR VALUES
  // For local Appwrite, use 'http://localhost/v1' or 'http://10.0.2.2/v1' for emulator
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectId = '69837474001f4bcc8d6b';
  static const String databaseId = 'restaurant_db';
  static const String collectionId = 'orders';

  void init() {
    client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(
        status: true,
      ); // For self-signed certificates, only use for development

    databases = Databases(client);
    account = Account(client);
    realtime = Realtime(client);

    print("Appwrite Initialized");
  }

  Future<void> loginAnonymously() async {
    try {
      await account.createAnonymousSession();
      print("Logged in anonymously");
    } catch (e) {
      print("Login error: $e");
    }
  }

  Future<Document?> createOrder(Map<String, dynamic> data) async {
    try {
      return await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: data,
      );
    } catch (e) {
      print("Error creating order: $e");
      return null;
    }
  }

  Stream<RealtimeMessage> subscribeToOrders() {
    return realtime.subscribe([
      'databases.$databaseId.collections.$collectionId.documents',
    ]).stream;
  }

  Future<List<Document>> getPendingOrders() async {
    try {
      final result = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal('status', 'pending'),
          Query.orderDesc('created_at'),
        ],
      );
      return result.documents;
    } catch (e) {
      print("Error getting orders: $e");
      return [];
    }
  }
}
