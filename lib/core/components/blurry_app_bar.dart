import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/utils/colors.dart';

class BlurryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  const BlurryAppBar({
    super.key,
    required this.title,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
