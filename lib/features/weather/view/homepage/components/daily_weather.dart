import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/models/forecast_model.dart';
import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class DailyWeather extends StatelessWidget {
  final bool isDay;
  final num longitude;
  final num latitude;
  const DailyWeather(
      {Key? key,
      required this.isDay,
      required this.longitude,
      required this.latitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForecastViewModel>.reactive(
      onModelReady: (model) =>
          model.getForecast(latitude.toString(), longitude.toString()),
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
          color: isDay ? Colors.orangeAccent.shade100 : Colors.blue.shade800,
          borderRadius: BorderRadius.circular(25),
        ),
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.1,
        child: model.isBusy
            ? const SizedBox()
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: model.forecastList?.length,
                itemBuilder: (BuildContext context, index) {
                  String? iconName =
                      model.forecastList?[index].weather![0].icon;
                  List<WeatherList>? forecastList = model.forecastList;
                  return Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayName(forecastList![index].dt),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "${forecastList[index].main!.temp!.toInt()} C°",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      iconImageWidget(iconName, context),
                    ],
                  );
                },
              ),
      ),
      viewModelBuilder: () => ForecastViewModel(),
    );
  }

  Image iconImageWidget(String? iconName, BuildContext context) {
    return Image.asset(
      "assets/weather/icon_$iconName.png",
      width: MediaQuery.of(context).size.width * 0.16,
      height: MediaQuery.of(context).size.height * 0.1,
    );
  }

  String dayName(num? epoch) {
    DateTime sunsetTime =
        DateTime.fromMillisecondsSinceEpoch(epoch!.toInt() * 1000);
    return DateFormat('EE').format(sunsetTime);
  }
}
