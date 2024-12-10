import 'package:flutter_weather_conditions/core/components/weather_conditions.dart';
import 'package:flutter_weather_conditions/interfaces/weather.dart';
import 'package:flutter_weather_conditions/model/weather_model.dart';

// Centralized definition of weather types
class WeatherDefinitions {
  static final List<Weather> weatherTypes = [
    NightThunderstorm(),
    DayThunderstorm(),
    NightRain(),
    DayRain(),
    NightSnow(),
    DaySnow(),
    SunnyDay(),
    Night(),
    Day(),
    CloudyNight(),
    CloudyDay(),
    NightHazy(),
    DayHazy(),
    NightOvercast(),
    DayOvercast(),
  ];
}

// Utility for transforming weather to WeatherModel
class WeatherUtil {
  // Getter for WeatherModel from weather
  List<WeatherModel> get getWeatherModel => WeatherDefinitions.weatherTypes
      .map<WeatherModel>((weather) => getWeather(weather))
      .toList();

  WeatherModel getWeather(Weather weather) => weather.getWeather();
}
