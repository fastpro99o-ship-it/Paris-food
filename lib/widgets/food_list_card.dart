import 'dart:ui';
import 'package:flutter/material.dart';

class FoodListCard extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onTap;
  final VoidCallback onCartTap;

  const FoodListCard({
    super.key,
    required this.title,
    required this.price,
    required this.onTap,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110, // Slightly taller
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFF3A402).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Text Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: const Color(0xFFF3A402), // Gold Text for Title
                          fontSize: 18, // Adjusted
                          letterSpacing: 1.0,
                          fontFamily: 'JotiOne',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),

                  // Right: Cart Button
                  GestureDetector(
                    onTap: onCartTap,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF3A402),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xFFF3A402),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
