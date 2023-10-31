import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/locator.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_changed_view.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_variable.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/daily_weather.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/icon_widget.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/location_view.dart';
import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherViewModel>.reactive(
      viewModelBuilder: () => WeatherViewModel(),
      onModelReady: (model) => model.initialSetup(),
      builder: (context, model, child) {
        var currentWeather = model.currentWeather;
        var sunrise = currentWeather!.sys!.sunrise;
        var sunset = currentWeather.sys!.sunset;
        DateTime currentTime = DateTime.now();
        final DateTime sunriseTime =
            DateTime.fromMillisecondsSinceEpoch(sunrise! * 1000);
        final DateTime sunsetTime =
            DateTime.fromMillisecondsSinceEpoch(sunset! * 1000);
        late Color backgroundColor;
        bool isDay = false;
        if (currentTime.isAfter(sunriseTime) &&
            currentTime.isBefore(sunsetTime)) {
          backgroundColor = const Color.fromARGB(230, 255, 187, 0);
          isDay = true;
        } else {
          backgroundColor = const Color.fromARGB(255, 15, 68, 112);
          isDay = false;
        }
        var forecastProvider = locator<ForecastViewModel>();
        forecastProvider.getForecast(currentWeather.coord!.lat.toString(),
            currentWeather.coord!.lon.toString());

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  CityChangedView(
                    isDay: isDay,
                  ),
                  model.isRequestPending
                      ? buildBusyIndicator()
                      : model.isRequestPending != false
                          ? const Center(
                              child: Text('Oops... something went wrong',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white)))
                          : LocationView(
                              longitude:
                                  model.currentWeather!.coord!.lon!.toDouble(),
                              latitude:
                                  model.currentWeather!.coord!.lat!.toDouble(),
                              city: model.currentWeather!.name,
                            ),
                  IconWidget(
                    assetName: model.currentWeather!.weather![0].icon!,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      model.currentWeather!.weather![0].description
                          .toString()
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "${model.currentWeather!.main!.temp!.toInt()} C°",
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        "Feels Like: ${model.currentWeather!.main!.feelsLike!.toInt()} C°",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  _sizedBox(context),
                  CityVariables(
                    isDay: isDay,
                    currentWeather: model.currentWeather!,
                  ),
                  _sizedBox(context),
                  DailyWeather(
                    isDay: isDay,
                    longitude: model.currentWeather!.coord!.lon!,
                    latitude: model.currentWeather!.coord!.lat!,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }

  Widget buildBusyIndicator() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        SizedBox(
          height: 20,
        ),
        Text(
          'Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
