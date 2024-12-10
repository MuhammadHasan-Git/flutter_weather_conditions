import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/model/weather_model.dart';

class WeatherBackground extends StatelessWidget {
  final WeatherModel weatherModel;
  final Widget child;
  const WeatherBackground({
    super.key,
    required this.child,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: weatherModel.backgroundColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: weatherModel.foreground != null
                  ? Align(
                      key: ValueKey(weatherModel.weatherStatus),
                      alignment: Alignment.topCenter,
                      child: weatherModel.foreground,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
