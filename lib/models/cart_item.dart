class CartItem {
  final String title;
  final String imagePath;
  final double price;
  final int quantity;
  final bool isSpicy;

  CartItem({
    required this.title,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.isSpicy,
  });

  double get total => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'price': price,
      'quantity': quantity,
      'isSpicy': isSpicy,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      title: json['title'] ?? '',
      imagePath: json['imagePath'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      isSpicy: json['isSpicy'] ?? false,
    );
  }
}
