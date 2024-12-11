import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/painter/rain_drop.dart';

class RainAnimation extends StatefulWidget {
  final Color dropColor;
  final int totalDrops;
  final double minVelocity;
  final double maxVelocity;

  const RainAnimation({
    super.key,
    required this.dropColor,
    this.totalDrops = 250, // Default number of raindrops
    this.minVelocity = 300.0, // Default minimum velocity
    this.maxVelocity = 600.0, // Default maximum velocity
  });

  @override
  State<RainAnimation> createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<RainDrop> _raindrops = [];
  late double _lastUpdateTime;
  final double speedMultiplier = 3.5;

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
      duration: const Duration(milliseconds: 16),
    )..addListener(_update);

    _lastUpdateTime =
        _controller.lastElapsedDuration?.inMilliseconds.toDouble() ?? 0.0;

    _controller.repeat();
  }

  void _update() {
    final currentTime =
        _controller.lastElapsedDuration?.inMilliseconds.toDouble() ?? 0.0;
    final deltaTime =
        (currentTime - _lastUpdateTime) / 1000; // Convert to seconds
    _lastUpdateTime = currentTime;

    final height = MediaQuery.of(context).size.height;

    setState(() {
      for (var drop in _raindrops) {
        drop.update(height, deltaTime, speedMultiplier);
      }
    });
  }

  void _initializeRaindrops() {
    final size = MediaQuery.of(context).size;
    final random = Random();
    _raindrops = List.generate(
      widget.totalDrops,
      (index) => RainDrop(
        length: 12,
        x: random.nextDouble() * size.width,
        y: random.nextDouble() * size.height,
        velocity:
            random.nextDouble() * (widget.maxVelocity - widget.minVelocity) +
                widget.minVelocity,
      ),
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
