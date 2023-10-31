import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mart_tech_test/core/models/weather_model.dart';

class WeatherService {
  String _key = "2f486d31ac1b60c7629402f9eaaf4b97";
  String baseApiCityName = "https://api.openweathermap.org/data/2.5/weather?q=";
  String baseApiCoord = "https://api.openweathermap.org/data/2.5/weather";

  Uri getUrltoCityName(String cityName) =>
      Uri.parse("$baseApiCityName$cityName&appid=$_key&units=metric&lang=tr");
  Uri getUrltoCoord(String lat, String lon) => Uri.parse(
      "$baseApiCoord?lat=$lat&lon=$lon&appid=$_key&units=metric&lang=tr");

  Future<WeatherModel?> fetchWeatherToCityName(String cityName) async {
    try {
      http.Response response = await http.get(getUrltoCityName(cityName));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = json.decode(response.body);
        WeatherModel weather = WeatherModel.fromJson(data);
        return weather;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }

  Future<WeatherModel?> fetchWeatherToCoord(String lat, String lon) async {
    try {
      http.Response response = await http.get(getUrltoCoord(lat, lon));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = json.decode(response.body);
        WeatherModel weather = WeatherModel.fromJson(data);
        return weather;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }
}
