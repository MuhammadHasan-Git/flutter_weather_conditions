import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/model/snow_ball.dart';

class SnowPainter extends CustomPainter {
  final List<SnowBall> snows;
  final bool isRunning;
  final Color snowColor;
  final bool hasSpinningEffect;

  SnowPainter({
    required this.isRunning,
    required this.snows,
    required this.snowColor,
    required this.hasSpinningEffect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint;

    if (hasSpinningEffect) {
      paint = Paint()
        ..color = snowColor
        ..isAntiAlias = true
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
        ..shader = LinearGradient(
          colors: [snowColor, snowColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.mirror,
        ).createShader(Rect.fromCircle(
          center: const Offset(0, 0),
          radius: 15,
        ));
    } else {
      paint = Paint()..color = snowColor;
    }

    for (int i = 0; i < snows.length; i++) {
      SnowBall snow = snows[i];
      canvas.drawCircle(Offset(snow.x, snow.y += 2.5), snow.radius, paint);
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) => isRunning;
}
