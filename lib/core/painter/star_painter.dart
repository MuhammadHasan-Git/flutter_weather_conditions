import 'dart:math';
import 'package:flutter/material.dart';

class StarrySkyPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random = Random();
  final int starCount = 100;
  final double minStarSize = 1.0;
  final double maxStarSize = 2.0;
  final List<Offset> starPositions = [];
  final List<double> starSizes = [];
  final List<double> sparkleOffsets = [];
  final List<double> minOpacities = [];

  StarrySkyPainter({required this.animation}) : super(repaint: animation) {
    for (int i = 0; i < starCount; i++) {
      starPositions.add(
        Offset(random.nextDouble(), random.nextDouble()),
      );
      starSizes.add(
        random.nextDouble() * (maxStarSize - minStarSize) + minStarSize,
      );
      sparkleOffsets.add(random.nextDouble() * 2 * pi);
      minOpacities.add(random.nextDouble() * 0.2 + 0.5); // Between 0.5 and 0.7
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < starCount; i++) {
      // Calculate sparkle opacity based on a sine wave and random offset
      final opacity = minOpacities[i] +
          (0.5 * sin(animation.value * 2 * pi + sparkleOffsets[i]));
      paint.color = Colors.white.withOpacity(opacity.clamp(0.5, 1.0));
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

      // Scale star position to screen size
      final starOffset = Offset(
        starPositions[i].dx * size.width,
        starPositions[i].dy * size.height,
      );

      canvas.drawCircle(starOffset, starSizes[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
