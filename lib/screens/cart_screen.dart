import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../widgets/checkout_sheet.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final VoidCallback onOrder; // ADDED

  const CartPage({super.key, required this.cartItems, required this.onOrder});

  void _showOrderSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => OrderTypeBottomSheet(onConfirm: onOrder),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item.total);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Mon Panier",
              style: TextStyle(
                fontSize: 32,
                color: const Color(0xFFF3A402),
                fontFamily: 'JotiOne',
              ),
            ),
          ),
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Text(
                      "Votre panier est vide.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 120),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(item.imagePath, width: 60, height: 60),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'JotiOne',
                                    ),
                                  ),
                                  Text(
                                    "${item.quantity} x ${item.price} DH",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  if (item.isSpicy)
                                    Text(
                                      "Option: Piquant",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              "${item.total.toStringAsFixed(0)} DH",
                              style: TextStyle(
                                color: const Color(0xFFF3A402),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          // Total & Checkout
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A).withOpacity(0.9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${totalPrice.toStringAsFixed(2)} DH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cartItems.isNotEmpty) {
                      _showOrderSelection(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Panier vide!",
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3A402),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Commander",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
