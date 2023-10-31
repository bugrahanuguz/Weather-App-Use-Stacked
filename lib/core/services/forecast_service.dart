import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mart_tech_test/core/models/forecast_model.dart';

class ForecastService {
  String _key = "2f486d31ac1b60c7629402f9eaaf4b97";
  String baseApi = "https://api.openweathermap.org/data/2.5/forecast";
  Uri getUrl(String lat, String lon) =>
      Uri.parse("$baseApi?lat=$lat&lon=$lon&appid=$_key&units=metric");

  Future fetchForecast(String latt, String lonn) async {
    print(getUrl(latt, lonn));
    http.Response response = await http.get(getUrl(latt, lonn));
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      Forecast weather = Forecast.fromJson(data);
      return weather;
    }
  }
}