import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/painter/snow_painter.dart';
import 'package:flutter_weather_conditions/model/snow_ball.dart';

const double angleIncrementation = 0.01;

class SnowAnimation extends StatefulWidget {
  ///
  /// Give the amount of particles to display on the screen
  ///
  final int totalSnow;

  ///
  /// Give the speed of the snow particles
  /// note that the velocity of each ball will depend on the its size
  /// (radius)
  /// The bigger snow balls will fall faster and the smaller snow balls will
  /// fall slower
  ///
  final double speed;

  ///
  /// Tells whether the animation is starting or not
  ///
  final bool isRunning;

  ///
  /// Give the max radius size of the snow ball object
  ///
  final double maxRadius;

  ///
  /// Give the main color of the Snowball
  ///
  final Color snowColor;

  ///
  /// Display the linear gradient with  [snowColor] and [Colors.white60] on the snowball
  /// if true else just display given [snowColor]
  ///
  final bool hasSpinningEffect;

  ///
  /// Start the snowing animation from the top if set to true
  /// otherwise start from the whole screens boundaries
  ///
  final bool startSnowing;

  ///
  /// If true , set a linear fall off otherwise stormy falls
  ///
  final bool linearFallOff;

  const SnowAnimation({
    super.key,
    required this.totalSnow,
    required this.speed,
    required this.isRunning,
    required this.snowColor,
    this.maxRadius = 4,
    this.linearFallOff = true,
    this.hasSpinningEffect = true,
    this.startSnowing = false,
  });
  @override
  State<SnowAnimation> createState() => _SnowAnimationState();
}

class _SnowAnimationState extends State<SnowAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double W = 0;
  double H = 0;

  final Random _rnd = Random();
  final List<SnowBall> _snows = [];
  double angle = 0;

  @override
  void didChangeDependencies() {
    init();
    super.didChangeDependencies();
  }

  Future<void> _replaceSnowBallWithNewParameters(int previousTotalSnow) async {
    List<SnowBall> copySnow = _snows;

    for (int i = 0; i < previousTotalSnow; i++) {
      final SnowBall snow = copySnow.elementAt(i);
      final double radius = _rnd.nextDouble() * widget.maxRadius + 1.0;
      final double generatedRadius = _rnd.nextDouble() * widget.speed;
      final double speed =
          generatedRadius >= (widget.maxRadius - widget.maxRadius / 4)
              ? generatedRadius
              : generatedRadius / 3;

      _snows[i] = SnowBall(
        x: snow.x,
        y: snow.y,
        radius: radius,
        density: speed,
      );
    }
  }

  Future<void> init({bool hasInit = false, int previousTotalSnow = 0}) async {
    final Size size = MediaQuery.of(context).size;
    W = size.width;
    H = size.height;

    if (hasInit) {
      /// only reset balls after the first init is done
      await _replaceSnowBallWithNewParameters(previousTotalSnow);
      final int newTotalSnow = widget.totalSnow - previousTotalSnow;
      if (newTotalSnow > 0) {
        await _createSnowBall(newBallToAdd: newTotalSnow);
      } else {
        _snows.removeRange(0, newTotalSnow.abs());
      }
    } else {
      controller = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        vsync: this,
        duration: const Duration(milliseconds: 5000),
      )..addListener(
          () {
            if (mounted) {
              setState(() {
                update();
              });
            }
          },
        );

      controller.repeat();
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _createSnowBall({required int newBallToAdd}) async {
    final int inverseYAxis = widget.startSnowing ? -1 : 1;

    for (int i = 0; i < newBallToAdd; i++) {
      final double radius = _rnd.nextDouble() * widget.maxRadius + 2;
      final double density = _rnd.nextDouble() * widget.speed;

      final double x = _rnd.nextDouble() * W;

      /// if [widget.startSnowing] is true the we reverse the Y axis to give
      /// the feeling of starting snow.
      /// otherwise just keep the Y axis as is.
      final double y = _rnd.nextDouble() * H * inverseYAxis;

      _snows.add(
        SnowBall(
          x: x,
          y: y,
          radius: radius,
          density: density,
        ),
      );
    }
  }

  Future<void> update() async {
    angle += angleIncrementation;

    if (widget.totalSnow != _snows.length) {
      await _createSnowBall(newBallToAdd: widget.totalSnow);
    }

    for (int i = 0; i < widget.totalSnow; i++) {
      final SnowBall snow = _snows.elementAt(i);
      final double sinX = widget.linearFallOff ? snow.density : snow.radius;

      /// make the snow heavier, faster for bigger snow balls
      snow.y += (cos(angle + snow.density) + snow.radius).abs() * widget.speed;
      snow.x += sin(sinX) * 2 * widget.speed;

      // If the flake is exiting widget parent's frame
      if (snow.x > W + (snow.radius) ||
          snow.x < -(snow.radius) ||
          snow.y > H + (snow.radius) ||
          snow.y < -(snow.radius)) {
        if (i % 4 > 0) {
          _snows[i] = SnowBall(
              x: _rnd.nextDouble() * W,
              y: -10,
              radius: snow.radius,
              density: snow.density);
        } else if (i % 5 > 0) {
          _snows[i] = SnowBall(
              x: (_rnd.nextDouble() * W) - _rnd.nextDouble() * 10,
              y: 0,
              radius: snow.radius,
              density: snow.density);
        } else {
          _snows[i] = SnowBall(
              x: (_rnd.nextDouble() * W) - _rnd.nextDouble() * 10,
              y: -_rnd.nextDouble() * 10,
              radius: snow.radius,
              density: snow.density);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRunning && !controller.isAnimating) {
      controller.repeat();
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      /// update Boundaries when Constraints change
      W = constraints.maxWidth;
      H = constraints.maxHeight;

      return CustomPaint(
        willChange: widget.isRunning,
        size: Size.infinite,
        painter: SnowPainter(
          isRunning: widget.isRunning,
          snows: _snows,
          snowColor: widget.snowColor,
          hasSpinningEffect: widget.hasSpinningEffect,
        ),
      );
    });
  }
}
