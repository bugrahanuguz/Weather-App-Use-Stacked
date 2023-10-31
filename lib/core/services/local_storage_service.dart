import 'package:hive/hive.dart';

class LocalStorageService {
  Future<void> saveLocation(double latitude, double longitude) async {
    final box = await Hive.openBox('locationBox');
    await box.put('latitude', latitude);
    await box.put('longitude', longitude);
    await box.close();
  }

  Future<List<double>> getLocation() async {
    final box = await Hive.openBox('locationBox');
    final double latitude = box.get('latitude', defaultValue: 0.0);
    final double longitude = box.get('longitude', defaultValue: 0.0);
    await box.close();
    return [latitude, longitude];
  }
}