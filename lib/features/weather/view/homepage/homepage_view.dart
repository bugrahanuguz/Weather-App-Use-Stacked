import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_changed_view.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_variable.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/daily_weather.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/icon_widget.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/location_view.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherViewModel>.reactive(
      viewModelBuilder: () => WeatherViewModel(),
      onModelReady: (model) async {
        await model.initialSetup();
      },
      builder: (context, model, child) {
        String newCity = "";
        double longitude = model.currentWeather!.coord!.lon!.toDouble();
        double latitude = model.currentWeather!.coord!.lat!.toDouble();
        WeatherModel? currentWeather = model.currentWeather;
        if (currentWeather != null && !model.isBusy) {
          bool isDay = model.determineIsDay(currentWeather);

          return Scaffold(
            backgroundColor: isDay
                ? const Color.fromARGB(230, 255, 187, 0)
                : const Color.fromARGB(255, 15, 68, 112),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    CityChangedView(
                      isDay: isDay,
                      newCity: newCity,
                      model: model,
                    ),
                    model.isRequestPending
                        ? buildBusyIndicator()
                        : model.isRequestPending != false
                            ? errorText()
                            : LocationView(
                                longitude: longitude,
                                latitude: latitude,
                                city: currentWeather.name,
                              ),
                    IconWidget(
                      assetName: currentWeather.weather![0].icon!,
                    ),
                    descriptionTextWidget(context, currentWeather),
                    Column(
                      children: [
                        tempTextWidget(currentWeather),
                        feelsLikeTextWidget(currentWeather),
                      ],
                    ),
                    _sizedBox(context),
                    CityVariables(
                      isDay: isDay,
                      currentWeather: currentWeather,
                    ),
                    _sizedBox(context),
                    DailyWeather(
                      isDay: isDay,
                      longitude: longitude,
                      latitude: latitude,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  SizedBox descriptionTextWidget(
      BuildContext context, WeatherModel currentWeather) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        currentWeather.weather![0].description.toString().toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Container tempTextWidget(WeatherModel currentWeather) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        "${currentWeather.main!.temp!.toInt()} C°",
        style: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Text feelsLikeTextWidget(WeatherModel currentWeather) {
    return Text(
      "Feels Like: ${currentWeather.main!.feelsLike!.toInt()} C°",
      style: const TextStyle(color: Colors.white),
    );
  }

  Center errorText() {
    return const Center(
        child: Text('Oops... something went wrong',
            style: TextStyle(fontSize: 21, color: Colors.white)));
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
