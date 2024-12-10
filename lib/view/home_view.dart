import 'package:flutter/material.dart';
import 'package:flutter_weather_conditions/controller/home_view_controller.dart';
import 'package:flutter_weather_conditions/core/components/blurry_app_bar.dart';
import 'package:flutter_weather_conditions/core/components/weather_background.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewController>(
      init: HomeViewController(),
      builder: (controller) => WeatherBackground(
        weatherModel: controller.weatherConditions[controller.currentPageIndex],
        child: Scaffold(
          appBar: BlurryAppBar(
            title: controller
                .weatherConditions[controller.currentPageIndex].weatherStatus,
          ),
          backgroundColor: Colors.transparent,
          body: PageView.builder(
            itemCount: controller.weatherConditions.length,
            onPageChanged: (index) => controller.changePageIndex(index),
            itemBuilder: (context, index) => const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
