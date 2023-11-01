import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/locator.dart';
import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';

class CityChangedView extends StatelessWidget {
  const CityChangedView({
    super.key,
    required this.isDay,
    required this.newCity, required this.model,
  });

  final bool isDay;
  final String newCity;
  final WeatherViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
      padding: const EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isDay ? Colors.orangeAccent.shade100 : Colors.blue.shade800,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              model.getWeatherForCity(newCity, locator<ForecastViewModel>());
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enter City'),
              onSubmitted: (String newCity) {
                newCity = newCity;
                model.getWeatherForCity(newCity, locator<ForecastViewModel>());
              },
            ),
          ),
        ],
      ),
    );
  }
}
