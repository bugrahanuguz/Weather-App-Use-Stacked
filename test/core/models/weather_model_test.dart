import 'package:test/test.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';

void main() {
  group('WeatherModel Tests', () {
    late WeatherModel weather;

    setUp(() {
      final Map<String, dynamic> testData = {
        'coord': {'lon': 50.0, 'lat': 30.0},
        'weather': [
          {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
        ],
        'base': 'stations',
      };
      weather = WeatherModel.fromJson(testData);
    });

    test('fromJson creates WeatherModel object', () {
      expect(weather, isA<WeatherModel>());
      expect(weather.coord, isA<Coord>());
      expect(weather.weather, isA<List<Weather>>());
      expect(weather.base, equals('stations'));
    });

    test('mapStringToWeatherCondition returns correct enum', () {
      final WeatherCondition condition = WeatherModel.mapStringToWeatherCondition('Clear', 10);
      expect(condition, equals(WeatherCondition.clear));
    });

    test('mapStringToWeatherCondition returns correct cloudiness', () {
      final WeatherCondition condition = WeatherModel.mapStringToWeatherCondition('Clouds', 90);
      expect(condition, equals(WeatherCondition.heavyCloud));
    });

    test('mapStringToWeatherCondition returns unknown for unrecognized input', () {
      final WeatherCondition condition = WeatherModel.mapStringToWeatherCondition('Unknown Weather', 0);
      expect(condition, equals(WeatherCondition.unknown));
    });
  });
}
