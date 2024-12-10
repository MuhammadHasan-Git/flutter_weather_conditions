import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/core/components/animations/lightning_aniamtion.dart';
import 'package:flutter_weather_conditions/core/components/animations/rain_animation.dart';
import 'package:flutter_weather_conditions/core/components/animations/snow_animation.dart';
import 'package:flutter_weather_conditions/core/components/animations/start_animation.dart';
import 'package:flutter_weather_conditions/core/components/animations/sun_animation.dart';
import 'package:flutter_weather_conditions/core/utils/colors.dart';
import 'package:flutter_weather_conditions/interfaces/weather.dart';
import 'package:flutter_weather_conditions/model/weather_model.dart';

class Day implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Clear (Day)',
        backgroundColors: day,
      );
}

class Night implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Clear (Night)',
        backgroundColors: night,
        foreground: const SparklingStarAnimation(),
      );
}

class SunnyDay implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Sunny',
        backgroundColors: day,
        foreground: const SunAnimation(),
      );
}

class CloudyDay implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Cloudy (Day)',
        backgroundColors: cloudyDay,
        foreground: Image.asset(
          'assets/images/day_cloudy.webp',
          gaplessPlayback: true,
          repeat: ImageRepeat.repeat,
        ),
      );
}

class CloudyNight implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Cloudy (Night)',
        backgroundColors: cloudyNight,
        foreground: Image.asset(
          'assets/images/night_cloudy.webp',
          gaplessPlayback: true,
          repeat: ImageRepeat.repeat,
        ),
      );
}

class DayHazy implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Hazy (Day)',
        backgroundColors: dayHazy,
      );
}

class NightHazy implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Hazy (Night)',
        backgroundColors: nightHazy,
      );
}

class DaySnow implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Snowing (Day)',
        backgroundColors: daySnow,
        foreground: const SnowAnimation(
          totalSnow: 100,
          maxRadius: 1.5,
          speed: 0.6,
          isRunning: true,
          snowColor: white,
        ),
      );
}

class NightSnow implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Snowing (Night)',
        backgroundColors: nightSnow,
        foreground: const SnowAnimation(
          totalSnow: 100,
          maxRadius: 1.5,
          speed: 0.6,
          isRunning: true,
          snowColor: white,
        ),
      );
}

class DayOvercast implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Overcast (Day)',
        backgroundColors: dayOvercast,
        foreground: Image.asset('assets/images/day_overcast.webp'),
      );
}

class NightOvercast implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Overcast (Night)',
        backgroundColors: nightOvercast,
        foreground: Image.asset('assets/images/night_overcast.webp'),
      );
}

class DayRain implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Raining (Day)',
        backgroundColors: dayRain,
        foreground: Stack(
          children: [
            Image.asset('assets/images/day_rain.webp'),
            const RainAnimation(dropColor: Colors.white12),
          ],
        ),
      );
}

class NightRain implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Raining (Night)',
        backgroundColors: cloudyNight,
        foreground: Stack(
          children: [
            Image.asset('assets/images/night_rain.webp'),
            const RainAnimation(dropColor: Colors.white10),
          ],
        ),
      );
}

class DayRainWithThunder implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Thunderstorm (Day)',
        backgroundColors: dayRain,
        foreground: Stack(
          children: [
            const LightningEffect(),
            Image.asset('assets/images/day_rain.webp'),
            const RainAnimation(dropColor: Colors.white12),
          ],
        ),
      );
}

class NightRainWithThunder implements Weather {
  @override
  WeatherModel getWeather() => WeatherModel(
        weatherStatus: 'Thunderstorm (Night)',
        backgroundColors: cloudyNight,
        foreground: Stack(
          children: [
            const LightningEffect(),
            Image.asset('assets/images/night_rain.webp'),
            const RainAnimation(dropColor: Colors.white10),
          ],
        ),
      );
}
