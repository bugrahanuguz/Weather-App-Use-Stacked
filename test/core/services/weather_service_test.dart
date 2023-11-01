import 'package:flutter_test/flutter_test.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';
import 'package:mart_tech_test/core/services/weather_service.dart';

void main() {
  group('Weather Service Tests', () {
    late WeatherService weatherService;

    setUp(() {
      weatherService = WeatherService();
    });

    test('fetchWeatherToCityName returns a WeatherModel on success', () async {
      const cityName = 'Istanbul'; 

      final weather = await weatherService.fetchWeatherToCityName(cityName);

      expect(weather, isA<WeatherModel>());
    });

    test('fetchWeatherToCoord returns a WeatherModel on success', () async {
      const latitude = '41.0082'; 
      const longitude = '28.9784'; 

      final weather = await weatherService.fetchWeatherToCoord(latitude, longitude);

      expect(weather, isA<WeatherModel>());
    });
  });
}
