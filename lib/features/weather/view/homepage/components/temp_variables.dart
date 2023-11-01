import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';

class TempVariables extends StatelessWidget {
  const TempVariables({
    super.key,
    required this.currentWeather,
  });

  final WeatherModel? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tempTextWidget(currentWeather),
        feelsLikeTextWidget(currentWeather),
      ],
    );
  }
}

Container tempTextWidget(WeatherModel? currentWeather) {
  return Container(
    padding: const EdgeInsets.only(left: 15),
    child: Text(
      "${currentWeather!.main!.temp!.toInt()} C°",
      style: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

Container feelsLikeTextWidget(WeatherModel? currentWeather) {
  return Container(
    padding: const EdgeInsets.only(left: 15),
    child: Text(
      "Feels Like: ${currentWeather!.main!.feelsLike!.toInt()} C°",
      style: const TextStyle(color: Colors.white),
    ),
  );
}
