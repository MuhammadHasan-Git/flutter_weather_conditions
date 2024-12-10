import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/components/painter/rain_drop.dart';

class RainAnimation extends StatefulWidget {
  final Color dropColor;
  const RainAnimation({super.key, required this.dropColor});

  @override
  State<RainAnimation> createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<RainDrop> _raindrops = [];

  @override
  void didChangeDependencies() {
    _initializeRaindrops();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(
        () {
          final height = MediaQuery.of(context).size.height;
          setState(() {
            for (var drop in _raindrops) {
              drop.update(height);
            }
          });
        },
      );

    _controller.repeat();
  }

  void _initializeRaindrops() {
    final size = MediaQuery.of(context).size;
    _raindrops = List.generate(
      150,
      (index) {
        final random = Random();
        return RainDrop(
          length: 4,
          x: random.nextDouble() * size.width,
          y: random.nextDouble() * size.height,
          velocity: random.nextDouble() * 3 + 8,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: RainPainter(_raindrops, widget.dropColor));
  }
}
