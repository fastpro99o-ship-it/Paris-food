import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;
  final List<Color> gradientColors;

  const HeroCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    this.gradientColors = const [
      Color(0xFFB8860B), // Dark Goldenrod
      Color(0xFFF3A402), // Gold
      Color(0xFF8B6508), // Darker Gold
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),

          // Pattern/Texture Overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CustomPaint(painter: _GlowPainter()),
            ),
          ),

          // Content
          Positioned(
            right: 20,
            top: 60,
            child: Text(
              title,
              style: GoogleFonts.jotiOne(
                fontSize: 48,
                color: Colors.white.withOpacity(0.9),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          // Image (Left Side - Floating)
          Positioned(
            left: -10,
            bottom: 10,
            height: 180,
            width: 180,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) =>
                  const Icon(Icons.fastfood, size: 80, color: Colors.white),
            ),
          ),

          // Price Tag (Optional, maybe "From 25DH")
          Positioned(
            left: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gradientColors[1], width: 1),
              ),
              child: Text(
                price,
                style: GoogleFonts.poppins(
                  color: gradientColors[1],
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
}

class _GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Add subtle glow paint logic here if needed, currently empty for performance
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
