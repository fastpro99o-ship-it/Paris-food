import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParisFoodHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double progress = shrinkOffset / (maxExtent - minExtent);
    final double percent = progress.clamp(0.0, 1.0);

    final double fontSize = lerpDouble(42, 24, percent)!;
    final AlignmentGeometry alignment = Alignment.lerp(
      Alignment.center,
      Alignment.centerLeft,
      percent,
    )!;
    final double leftPadding = lerpDouble(0, 24, percent)!;

    return Container(
      padding: EdgeInsets.only(top: 40, left: leftPadding),
      alignment: alignment,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Text(
        'PARIS FOOD',
        style: GoogleFonts.jotiOne(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFF3A402),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200.0;
  @override
  double get minExtent => 100.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
