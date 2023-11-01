import 'package:test/test.dart';
import 'package:mart_tech_test/core/models/forecast_model.dart';

void main() {
  group('Forecast Tests', () {
    test('Forecast fromJson creates Forecast object', () {
      final Map<String, dynamic> testData = {
        'cod': '200',
        'message': 0,
        'cnt': 40,
        'list': [
          {
            'dt': 1634425200,
            'main': {'temp': 20.0},
            'weather': [
              {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
            ],
          }
        ],
        'city': {
          'id': 123456,
          'name': 'Test City',

        }
      };

      final Forecast forecast = Forecast.fromJson(testData);

      expect(forecast, isA<Forecast>());
      expect(forecast.cod, equals('200'));
      expect(forecast.message, equals(0));
      expect(forecast.cnt, equals(40));
      expect(forecast.list, isA<List<WeatherList>>());
      expect(forecast.city, isA<City>());
    });
  });

  group('WeatherList Tests', () {
    test('WeatherList fromJson creates WeatherList object', () {
      final Map<String, dynamic> testData = {
        'dt': 1634425200,
        'main': {'temp': 20.0},
        'weather': [
          {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
        ],

      };

      final WeatherList weatherList = WeatherList.fromJson(testData);

      expect(weatherList, isA<WeatherList>());
      expect(weatherList.dt, equals(1634425200));
      expect(weatherList.main, isA<Main>());
      expect(weatherList.weather, isA<List<Weather>>());
    });
  });

}
