import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/locator.dart';
import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';
import 'package:stacked/stacked.dart';

class CityEntryViewModel extends BaseViewModel {
  late String _city;
  late TextEditingController _cityEditController;

  CityEntryViewModel() {
    _city = '';
    _cityEditController = TextEditingController();
    _cityEditController.addListener(() {
      _city = _cityEditController.text;
      notifyListeners();
    });
  }

  String get city => _city;

  TextEditingController get cityEditController => _cityEditController;
  
  void refreshWeather(String newCity, BuildContext context) {
    var weatherViewModel = locator<WeatherViewModel>();
    var forecastViewModel = locator<ForecastViewModel>();

    weatherViewModel.getLatestWeather(_city, context, forecastViewModel);

    forecastViewModel.getForecast(
      weatherViewModel.currentWeather!.coord!.lat.toString(),
      weatherViewModel.currentWeather!.coord!.lon.toString(),
    );
  }

  void updateCity(String newCity) {
    _city = newCity;
    _cityEditController.text = newCity;
    notifyListeners();
  }
}
