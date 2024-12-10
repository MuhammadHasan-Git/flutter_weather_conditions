import 'package:flutter_weather_conditions/core/utils/weather_utils.dart';
import 'package:flutter_weather_conditions/model/weather_model.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  final WeatherUtil _weatherUtil = WeatherUtil();

  late List<WeatherModel> weatherConditions;

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  Future<void> changePageIndex(int index) async {
    _currentPageIndex = index;
    update();
  }

  @override
  void onInit() {
    weatherConditions = _weatherUtil.getWeatherModel;
    super.onInit();
  }
}
