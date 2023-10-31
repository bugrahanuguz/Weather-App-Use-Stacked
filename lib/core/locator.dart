import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Geolocator servisinin kaydedilmesi
  locator.registerLazySingleton(() => Geolocator());

  // Hive servisinin kaydedilmesi
  locator.registerLazySingleton(() async {
    final HiveInterface hive = Hive;
    final appDocumentDir = await hive.openBox('locationBox');
    return appDocumentDir;
  });
}
