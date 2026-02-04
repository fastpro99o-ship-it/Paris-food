import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryTitle;
  final String heroImagePath;
  final Color accentColor;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryTitle,
    required this.heroImagePath,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data for the list
    final List<Map<String, dynamic>> items = [
      {'name': 'CHEESE BURGER', 'price': '25DH'},
      {'name': 'CHICKEN BURGER', 'price': '25DH'},
      {'name': 'KING BURGER', 'price': '35DH'},
      {'name': 'DOUBLE BURGER', 'price': '45DH'},
      {'name': 'SPICY BURGER', 'price': '30DH'},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B6B00), // Dark Gold
              Color(0xFF1A1A1A), // Dark
              Color(0xFF000000), // Black
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. HERO CARD
              _buildHeroCard(),

              const SizedBox(height: 20),

              // 2. LIST OF ITEMS
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _buildMenuCard(item['name'], item['price']);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD4AF37).withOpacity(0.8), // Gold
            const Color(0xFFAA8800).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Stack(
        children: [
          // Glass effect noise or overlay could go here

          // Image on the Left (Large, realistic)
          Positioned(
            left: -20,
            bottom: -20,
            top: 10,
            child: Hero(
              tag: heroImagePath,
              child: Image.asset(
                heroImagePath,
                width: 240,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Title Text "BURGER" on the Right
          Positioned(
            right: 20,
            top: 40,
            child: Text(
              categoryTitle, // e.g. BURGER
              style: GoogleFonts.bebasNeue(
                // Using a condensed bold font generally fits "Modern" well, or JotiOne as used before
                textStyle: TextStyle(
                  fontSize: 50,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2,
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Price Label Bottom Left (or near image)
          Positioned(
            left: 20, // Adjust based on image
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: Text(
                "25DH", // Placeholder or from hero item
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String name, String price) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFD4AF37).withOpacity(0.3), // Gold border
              width: 1,
            ),
            gradient: LinearGradient(
              colors: [
                const Color(0xFFD4AF37).withOpacity(0.1),
                Colors.black.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: const Color(0xFFEFEFEF),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Shopping Cart Button
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    // Add to cart action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
