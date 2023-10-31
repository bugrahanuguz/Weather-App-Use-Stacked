import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';
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

  Future<WeatherModel> getWeather(String cityName) async {
    cityNamee = cityName;
    setBusy(true);
    final response = await service.fetchWeather(cityName);
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

      latest = await service.fetchWeather(city);
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
    final response = await service.fetchWeather(cityNamee!);
    currentWeather = response;
    currentWeather?.name = cityNamee;

    await forecastViewModel.getForecast(currentWeather!.coord!.lat.toString(),
        currentWeather!.coord!.lon.toString());
    return currentWeather!;
  }
}
