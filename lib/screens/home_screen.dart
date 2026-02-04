import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cart_item.dart';
import '../widgets/header_delegate.dart';
import '../widgets/menu_card.dart';
import '../widgets/product_details_sheet.dart';
import 'cart_screen.dart';
import 'category_menu_screen.dart'; // IMPORTED

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<CartItem> cartItems = [];

  void _addToCart(
    String title,
    String imagePath,
    double price,
    int qty,
    bool spicy,
  ) {
    setState(() {
      cartItems.add(
        CartItem(
          title: title,
          imagePath: imagePath,
          price: price,
          quantity: qty,
          isSpicy: spicy,
        ),
      );
    });
    // Navigator.pop(context); // Handled by sheet or ignored
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$title ajouté au panier!",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF3A402),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _openCategoryMenu(
    BuildContext context,
    String category,
    String imagePath,
    Color accentColor,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryMenuScreen(
          categoryName: category,
          heroImagePath: imagePath,
          accentColor: accentColor,
          onAddToCart: (item) {
            setState(() {
              cartItems.add(item);
            });
          },
        ),
      ),
    ).then((result) {
      if (result == 'open_cart') {
        setState(() {
          selectedIndex = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// LAYER 1: BACKGROUND
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.15, -0.6),
                  radius: 1.3,
                  colors: [Color(0xFFF3A402), Color(0xFF1A1A1A)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),

          /// LAYER 2: CONTENT (Switcher)
          Positioned.fill(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                // INDEX 0: HOME MENU
                CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: ParisFoodHeaderDelegate(),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 120,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.95,
                            ),
                        delegate: SliverChildListDelegate(
                          [
                            MenuCard(
                              title: 'BURGER',
                              imagePath: 'assets/burger.png',
                              accentColor: Colors.orange,
                              onTap: () => _openCategoryMenu(
                                context,
                                'BURGER',
                                'assets/burger.png',
                                Colors.orange,
                              ),
                            ),
                            MenuCard(
                              title: 'SANDWICH',
                              imagePath: 'assets/sandwich.png',
                              accentColor: Colors.brown,
                              onTap: () => _openCategoryMenu(
                                context,
                                'SANDWICH',
                                'assets/sandwich.png',
                                Colors.brown,
                              ),
                            ),
                            MenuCard(
                              title: 'PIZZA',
                              imagePath: 'assets/pizza.png',
                              accentColor: Colors.red,
                              onTap: () => _openCategoryMenu(
                                context,
                                'PIZZA',
                                'assets/pizza.png',
                                Colors.red,
                              ),
                            ),
                            MenuCard(
                              title: 'TACOS',
                              imagePath: 'assets/Tacos.png',
                              accentColor: Colors.amber,
                              onTap: () => _openCategoryMenu(
                                context,
                                'TACOS',
                                'assets/Tacos.png',
                                Colors.amber,
                              ),
                            ),
                            MenuCard(
                              title: 'PATES',
                              imagePath: 'assets/plats.png', // Placeholder
                              accentColor: Colors.yellow,
                              onTap: () => _openCategoryMenu(
                                context,
                                'PATES',
                                'assets/plats.png',
                                Colors.yellow,
                              ),
                            ),
                            MenuCard(
                              title: 'OMELETTES',
                              imagePath: 'assets/salad.png', // Placeholder
                              accentColor: Colors.orangeAccent,
                              onTap: () => _openCategoryMenu(
                                context,
                                'OMELETTES',
                                'assets/salad.png',
                                Colors.orangeAccent,
                              ),
                            ),
                            MenuCard(
                              title: 'SALADES',
                              imagePath: 'assets/salad.png',
                              accentColor: Colors.lightGreen,
                              onTap: () => _openCategoryMenu(
                                context,
                                'SALADES',
                                'assets/salad.png',
                                Colors.lightGreen,
                              ),
                            ),
                            MenuCard(
                              title: 'DESSERTS',
                              imagePath: 'assets/pasticcio.png', // Placeholder
                              accentColor: Colors.pink,
                              onTap: () => _openCategoryMenu(
                                context,
                                'DESSERTS',
                                'assets/pasticcio.png',
                                Colors.pink,
                              ),
                            ),
                            MenuCard(
                              title: 'BOISSONS',
                              imagePath:
                                  'assets/burger.png', // Placeholder (Need Drink)
                              accentColor: Colors.blue,
                              onTap: () => _openCategoryMenu(
                                context,
                                'BOISSONS',
                                'assets/burger.png',
                                Colors.blue,
                              ),
                            ),
                            MenuCard(
                              title: 'PETIT DÉJEUNER',
                              imagePath: 'assets/burger.png', // Placeholder
                              accentColor: Colors.teal,
                              onTap: () => _openCategoryMenu(
                                context,
                                'PETIT DÉJEUNER',
                                'assets/burger.png',
                                Colors.teal,
                              ),
                            ),
                            MenuCard(
                              title: 'SUPPLÉMENTS',
                              imagePath: 'assets/burger.png', // Placeholder
                              accentColor: Colors.grey,
                              onTap: () => _openCategoryMenu(
                                context,
                                'SUPPLÉMENTS',
                                'assets/burger.png',
                                Colors.grey,
                              ),
                            ),
                          ].map((card) => card).toList(),
                        ),
                      ),
                    ),
                  ],
                ),

                // INDEX 1: CART PAGE
                CartPage(
                  cartItems: cartItems,
                  onOrder: () {
                    setState(() {
                      cartItems.clear();
                    });
                  },
                ),

                // INDEX 2: CREDIT
                const Center(
                  child: Text(
                    "Payment Page",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          /// LAYER 3: NAVBAR
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      navItem(Icons.home, 0),
                      navItem(Icons.shopping_cart, 1),
                      navItem(Icons.credit_card, 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, int index) {
    bool isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 28,
        color: isActive ? Colors.amber : Colors.white,
      ),
    );
  }
}
