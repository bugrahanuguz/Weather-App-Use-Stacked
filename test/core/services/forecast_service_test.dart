import 'package:flutter_test/flutter_test.dart';
import 'package:mart_tech_test/core/models/forecast_model.dart';
import 'package:mart_tech_test/core/services/forecast_service.dart';

void main() {
  group('Forecast Service Tests', () {
    late ForecastService forecastService;

    setUp(() {
      forecastService = ForecastService();
    });

    test('fetchForecast returns a Forecast on success', () async {
      final latitude = '41.0082'; 
      final longitude = '28.9784'; 

      final forecast = await forecastService.fetchForecast(latitude, longitude);

      expect(forecast, isA<Forecast>());
    });
  });
}
