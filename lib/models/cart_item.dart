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
}
