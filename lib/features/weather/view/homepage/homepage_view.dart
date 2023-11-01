import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/weather_model.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_changed_view.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/city_variable.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/daily_weather.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/icon_widget.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/location_view.dart';
import 'package:mart_tech_test/features/weather/view/homepage/components/temp_variables.dart';
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
                                longitude: model.currentWeather!.coord!.lon!
                                    .toDouble(),
                                latitude: model.currentWeather!.coord!.lat!
                                    .toDouble(),
                                city: currentWeather.name,
                              ),
                    IconWidget(
                      assetName: currentWeather.weather![0].icon!,
                    ),
                    descriptionTextWidget(context, currentWeather),
                    TempVariables(currentWeather: currentWeather),
                    _sizedBox(context),
                    CityVariables(
                      isDay: isDay,
                      currentWeather: currentWeather,
                    ),
                    _sizedBox(context),
                    DailyWeather(
                      isDay: isDay,
                      longitude: model.currentWeather!.coord!.lon!.toDouble(),
                      latitude: model.currentWeather!.coord!.lat!.toDouble(),
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
