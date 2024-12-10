import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/components/painter/star_painter.dart';

class SparklingStarAnimation extends StatefulWidget {
  const SparklingStarAnimation({super.key});

  @override
  State<SparklingStarAnimation> createState() => _SparklingStarAnimationState();
}

class _SparklingStarAnimationState extends State<SparklingStarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarrySkyPainter(animation: _controller),
      child: Container(),
    );
  }
}
