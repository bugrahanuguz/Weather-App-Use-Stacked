import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mart_tech_test/core/services/forecast_service.dart';
import 'package:mart_tech_test/core/services/weather_service.dart';

import 'package:mart_tech_test/features/weather/viewmodels/forecast_view_model.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Geolocator servisinin kaydedilmesi
  final Geolocator geolocator = Geolocator();
  locator.registerLazySingleton(() => geolocator);
  // Hive servisinin kaydedilmesi
  locator.registerLazySingleton(() async {
    final HiveInterface hive = Hive;
    final appDocumentDir = await hive.openBox('locationBox');
    return appDocumentDir;
  });

  locator.registerLazySingleton(() => ForecastService());
  locator.registerLazySingleton(() => WeatherService());
  locator.registerLazySingleton(() => ForecastViewModel());
  locator.registerLazySingleton(() => WeatherViewModel());

}
