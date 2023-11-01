import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Konum servisi kapalı');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Konum izni reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
        'Kalıcı olarak konum izni reddedildi - ayarlardan düzeltebilirsiniz',
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}
