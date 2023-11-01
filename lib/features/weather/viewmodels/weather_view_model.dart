import 'package:geolocator/geolocator.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';
import 'package:mart_tech_test/core/services/location_service.dart';
import 'package:mart_tech_test/core/services/weather_service.dart';
import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:stacked/stacked.dart';

class WeatherViewModel extends BaseViewModel {
  bool isRequestPending = false;
  WeatherService service = WeatherService();
  String? cityNamee;
  WeatherModel? currentWeather;

  Future<void> initialSetup() async {
    await getLocationAndFetchForecast();
  }

  Future<WeatherModel> getLocationAndFetchForecast() async {
    var locationService = LocationService();
    setBusy(true);
    Position position = await locationService.getCurrentLocation();
    final response = await service.fetchWeatherToCoord(
        position.latitude.toString(), position.longitude.toString());
    currentWeather = response;
    setBusy(false);
    return currentWeather!;
  }

  bool determineIsDay(WeatherModel? currentWeather) {
    DateTime currentTime = DateTime.now();
    if (currentWeather != null && currentWeather.sys != null) {
      var sunrise = currentWeather.sys!.sunrise;
      var sunset = currentWeather.sys!.sunset;
      if (sunrise != null && sunset != null) {
        final DateTime sunriseTime =
            DateTime.fromMillisecondsSinceEpoch(sunrise.toInt() * 1000);
        final DateTime sunsetTime =
            DateTime.fromMillisecondsSinceEpoch(sunset.toInt() * 1000);

        if (currentTime.isAfter(sunriseTime) &&
            currentTime.isBefore(sunsetTime)) {
          return true;
        }
      }
    }
    return false; 
  }

  Future<WeatherModel?> getWeatherForCity(
      String city, ForecastViewModel forecastViewModel) async {
    setBusy(true);
      final latestWeather = await service.fetchWeatherToCityName(city);

      currentWeather = latestWeather;

      cityNamee = city;

      await forecastViewModel.getForecast(
        latestWeather!.coord!.lat.toString(),
        latestWeather.coord!.lon.toString(),
      );

    setBusy(false);
    notifyListeners();
    return currentWeather;
  }
}
