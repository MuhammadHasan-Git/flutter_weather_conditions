import 'dart:math';
import 'package:flutter/material.dart';

class LightningEffect extends StatefulWidget {
  const LightningEffect({super.key});

  @override
  State<LightningEffect> createState() => _LightningEffectState();
}

class _LightningEffectState extends State<LightningEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  final Random _random = Random();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 0.6).chain(CurveTween(curve: Curves.easeIn)),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.6, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 0.4).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.8,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.4, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.8,
      ),
    ]).animate(_controller);

    // Start the lightning effect
    _startLightningEffect();
  }

  Future<void> _startLightningEffect() async {
    _isAnimating = true;

    while (mounted && _isAnimating) {
      // Generate a random number of flashes between 1 and 5
      int flashes = _random.nextInt(5) + 1;

      for (int i = 0; i < flashes; i++) {
        if (!mounted) return;
        _controller.forward(from: 0.0);
        await Future.delayed(const Duration(milliseconds: 800));
      }

      // Generate a random delay between sequences (1 to 8 seconds)
      int randomDelay =
          _random.nextInt(8) + 1; // Random delay between 1 and 8 seconds
      await Future.delayed(Duration(seconds: randomDelay));
    }
  }

  @override
  void dispose() {
    _isAnimating = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: size.width,
        height: size.height,
        decoration:
            BoxDecoration(color: Colors.blueAccent.shade100.withOpacity(0.4)),
      ),
    );
  }
}
