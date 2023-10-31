import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';

class CityVariables extends StatelessWidget {
  final bool isDay;
  final WeatherModel currentWeather;
  const CityVariables(
      {super.key, required this.isDay, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: isDay ? Colors.orangeAccent.shade100 : Colors.blue.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildVariable(
            context: context,
            icon: Icons.water_drop,
            value: '${currentWeather.main!.humidity ?? 0} %',
          ),
          _buildVariable(
            context: context,
            icon: Icons.wind_power,
            value: '${(currentWeather.wind?.speed ?? 0 * 3.6).toInt()} km/h',
          ),
          _buildVariable(
            context: context,
            icon: Icons.cloud,
            value: '${currentWeather.clouds?.all ?? 0} %',
          ),
        ],
      ),
    );
  }

  Widget _buildVariable({
    required BuildContext context,
    required IconData icon,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        Text(value, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
