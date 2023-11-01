import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mart_tech_test/core/services/weather_service.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('WeatherViewModel Tests', () {
    test(
        'getLocationAndFetchForecast retrieves current weather for the user location',
        () async {
      final viewModel = WeatherViewModel();

      final weatherService = WeatherService();

      final weather = await weatherService.fetchWeatherToCoord(
        "41.0082",
        "28.9784",
      );

      viewModel.currentWeather = weather;

    });

    test('getWeatherForCity fetches the weather for a specified city',
        () async {
      final viewModel = WeatherViewModel();
      final weatherService = WeatherService();

      final cityName = 'Ankara';

      final weather = await weatherService.fetchWeatherToCityName(cityName);

      viewModel.currentWeather = weather;

    });
  });
}
