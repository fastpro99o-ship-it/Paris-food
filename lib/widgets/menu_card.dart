import 'dart:ui';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color accentColor;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          accentColor.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        stops: const [0.2, 1.0],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8860B).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontFamily: 'JotiOne',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
