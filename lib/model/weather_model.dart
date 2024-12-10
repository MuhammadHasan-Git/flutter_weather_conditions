import 'package:flutter/material.dart';

class WeatherModel {
  final String weatherStatus;
  final Widget? foreground;
  final List<Color> backgroundColors;
  WeatherModel({
    required this.weatherStatus,
    this.foreground,
    required this.backgroundColors,
  });
}
