import 'package:flutter/material.dart';

class RainDrop {
  double x;
  double y;
  double length;
  double velocity;

  RainDrop({
    required this.x,
    required this.y,
    required this.length,
    required this.velocity,
  });

  void update(double screenHeight, double deltaTime, double speedMultiplier) {
    y += velocity * deltaTime * speedMultiplier;
    if (y > screenHeight + length) {
      y = -length;
    }
  }
}

class RainPainter extends CustomPainter {
  final List<RainDrop> raindrops;
  final Color dropColor;
  RainPainter(this.raindrops, this.dropColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dropColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (var drop in raindrops) {
      canvas.drawLine(
        Offset(drop.x, drop.y),
        Offset(drop.x, drop.y + drop.length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
