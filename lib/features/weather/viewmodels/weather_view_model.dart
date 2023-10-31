import 'package:flutter/material.dart';
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
  Clouds? currentClouds;
  WeatherCondition? lastCondition;

  void initialSetup() {
    getLocationAndFetchForecast();
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

  Future<WeatherModel> getWeather(String cityName) async {
    cityNamee = cityName;
    setBusy(true);
    final response = await service.fetchWeatherToCityName(cityName);
    currentWeather = response;
    currentWeather?.name = cityNamee;
    setBusy(false);
    return currentWeather!;
  }

  Future<WeatherModel> getLatestWeather(String city, BuildContext context,
      ForecastViewModel forecastViewModel) async {
    setBusyForObject(currentWeather, true);
    WeatherModel? latest;
    try {
      await Future.delayed(Duration(seconds: 1), () => {});

      latest = await service.fetchWeatherToCityName(city);
    } catch (e) {
      "this.isRequestError = true";
    }

    await updateModel(latest!, city, context, forecastViewModel);
    forecastViewModel.getForecast(
        latest.coord!.lat.toString(), latest.coord!.lon.toString());
    setBusyForObject(currentWeather, false);
    return latest;
  }

  Future updateModel(WeatherModel forecast, String city, BuildContext context,
      ForecastViewModel forecastViewModel) async {
    cityNamee = city;
    final response = await service.fetchWeatherToCityName(cityNamee!);
    currentWeather = response;
    currentWeather?.name = cityNamee;

    await forecastViewModel.getForecast(currentWeather!.coord!.lat.toString(),
        currentWeather!.coord!.lon.toString());
    return currentWeather!;
  }
}
