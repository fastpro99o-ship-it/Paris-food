import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/hero_card.dart';
import '../widgets/food_list_card.dart';
import '../widgets/product_details_sheet.dart';
import '../models/cart_item.dart'; // IMPORTED

class CategoryMenuScreen extends StatelessWidget {
  final String categoryName;
  final String heroImagePath;
  final Color accentColor;
  final Function(CartItem) onAddToCart; // ADDED

  const CategoryMenuScreen({
    super.key,
    required this.categoryName,
    required this.heroImagePath,
    required this.accentColor,
    required this.onAddToCart, // ADDED
  });

  // Mock Data Helper
  List<Map<String, dynamic>> _getItems() {
    switch (categoryName.toUpperCase()) {
      case 'BURGER':
        return [
          {'title': 'Cheese Burger', 'price': '30DH'},
          {'title': 'Chicken Burger', 'price': '30DH'},
          {'title': 'King Burger', 'price': '40DH'},
          {'title': 'Double Chicken', 'price': '40DH'},
          {'title': 'Burger Américain', 'price': '40DH'},
        ];
      case 'SANDWICH':
      case 'PANINI':
        return [
          {'title': 'Sandwich Poulet', 'price': '25DH'},
          {'title': 'Sandwich Viande Hachée', 'price': '30DH'},
          {'title': 'Sandwich Mixte', 'price': '35DH'},
          {'title': 'Sandwich Saucisses', 'price': '25DH'},
          {'title': 'Panini Nugget', 'price': '25DH'},
          {'title': 'Panini Cordon Bleu', 'price': '30DH'},
        ];
      case 'PIZZA':
        return [
          {'title': 'Margherita', 'price': '30DH'},
          {'title': 'Végétarienne', 'price': '35DH'},
          {'title': 'Poulet', 'price': '40DH'},
          {'title': 'Thon', 'price': '40DH'},
          {'title': 'Viande Hachée', 'price': '45DH'},
          {'title': '4 Fromages', 'price': '45DH'},
          {'title': '4 Saisons', 'price': '45DH'},
          {'title': 'Fruits de Mer', 'price': '50DH'},
          {'title': 'Royal', 'price': '55DH'},
        ];
      case 'TACOS':
        return [
          {'title': 'Tacos Poulet', 'price': '35DH'},
          {'title': 'Tacos Viande Hachée', 'price': '40DH'},
          {'title': 'Tacos Mixte', 'price': '45DH'},
          {'title': 'Tacos Cordon Bleu', 'price': '40DH'},
          {'title': 'Tacos Nuggets', 'price': '35DH'},
        ];
      case 'PATES':
      case 'PASTA':
      case 'PÂTES':
        return [
          {'title': 'Carbonara', 'price': '30DH'},
          {'title': 'Poulet', 'price': '30DH'},
          {'title': 'Bolognaise', 'price': '30DH'},
          {'title': 'Fruits de Mer', 'price': '40DH'},
        ];
      case 'OMELETTES':
        return [
          {'title': 'Nature', 'price': '10DH'},
          {'title': 'Fromage', 'price': '15DH'},
          {'title': 'Poulet', 'price': '15DH'},
          {'title': 'Saucisses', 'price': '15DH'},
          {'title': 'Viande Hachée', 'price': '15DH'},
          {'title': 'Mixte', 'price': '20DH'},
          {'title': 'Kefta / Kébda', 'price': '20DH'},
          {'title': 'Crevettes', 'price': '25DH'},
        ];
      case 'SALAD':
      case 'SALADES':
        return [
          {'title': 'Marocaine', 'price': '15DH'},
          {'title': 'Variée', 'price': '20DH'},
          {'title': 'Mexicaine', 'price': '25DH'},
          {'title': 'Pêcheur', 'price': '30DH'},
        ];
      case 'DESSERTS':
        return [
          {'title': 'Crêpe', 'price': '15DH'},
          {'title': 'Gaufres', 'price': '20DH'},
          {'title': 'Panna Cotta', 'price': '20DH'},
          {'title': 'Crème Caramel', 'price': '20DH'},
          {'title': 'Tiramisu', 'price': '30DH'},
          {'title': 'Salade de Fruits', 'price': '20DH'},
        ];
      case 'BOISSONS':
        return [
          {'title': 'Jus d’orange', 'price': '10DH'},
          {'title': 'Jus de banane', 'price': '10DH'},
          {'title': 'Jus d’avocat', 'price': '15DH'},
          {'title': 'Jus panaché', 'price': '15DH'},
          {'title': 'Mojito', 'price': '15DH'},
          {'title': 'Canette', 'price': '6DH'},
        ];
      case 'BREAKFAST':
      case 'PETIT DÉJEUNER':
        return [
          {'title': 'Thé', 'price': '3DH'},
          {'title': 'Café', 'price': '3DH'},
          {'title': 'Jus au choix', 'price': '15DH'},
          {'title': 'Lait au chocolat', 'price': '8DH'},
          {'title': 'Msemen', 'price': '6DH'},
          {'title': 'Makhmar', 'price': '6DH'},
        ];
      default:
        return [
          {'title': categoryName, 'price': ''},
        ];
    }
  }

  void _showProductDetails(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProductDetailsSheet(
        title: title,
        imagePath:
            heroImagePath, // Reuse hero image for now, typically unique per item
        accentColor: accentColor,
        onAdd: (qty, spicy) {
          // Create CartItem and call callback
          final item = CartItem(
            title: title,
            imagePath: heroImagePath,
            price: 45.0, // Hardcoded for now based on previous sheet logic
            quantity: qty,
            isSpicy: spicy,
          );
          onAddToCart(item);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$title ajouté!"),
              backgroundColor: accentColor,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, -0.6),
                  radius: 1.5,
                  colors: [Color(0xFF2C2C2C), Colors.black],
                ),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              // Back Button & Cart Button & Navbar Spacer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Color(0xFFF3A402),
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context, 'open_cart'),
                      ),
                    ],
                  ),
                ),
              ),

              // Hero Card
              SliverToBoxAdapter(
                child: HeroCard(
                  title: categoryName,
                  imagePath: heroImagePath,
                  price: "From 25DH",
                  gradientColors: [
                    accentColor,
                    accentColor.withOpacity(0.8),
                    Colors.black,
                  ],
                ),
              ),

              // List Items
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = items[index];
                  return FoodListCard(
                    title: item['title'],
                    price: item['price'],
                    onTap: () => _showProductDetails(context, item['title']),
                    onCartTap: () {
                      // Quick Add logic (1 item, no spicy)
                      final cartItem = CartItem(
                        title: item['title'],
                        imagePath: heroImagePath,
                        price: double.parse(item['price'].replaceAll('DH', '')),
                        quantity: 1,
                        isSpicy: false,
                      );
                      onAddToCart(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item['title']} ajouté!"),
                          backgroundColor: accentColor,
                        ),
                      );
                    },
                  );
                }, childCount: items.length),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          ),
        ],
      ),
    );
  }
}
