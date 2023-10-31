import 'package:mart_tech_test/core/models/forecast_model.dart';
import 'package:mart_tech_test/core/services/forecast_service.dart';
import 'package:stacked/stacked.dart';

class ForecastViewModel extends BaseViewModel {
  ForecastService service = ForecastService();
  Forecast? forecast;
  List<WeatherList>? forecastList = [];

  Future getForecast(String lat, String lon) async {
    setBusy(true);
    final response = await service.fetchForecast(lat, lon);
    forecast = response;
    forecastList = [];
    for (var i in forecast!.list!) {
      if (i.dtTxt!.contains("15:00:00")) {
        forecastList!.add(i);
      }
    }
    setBusy(false);
    return forecastList;
  }
}