import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum servisi kapalıysa kullanıcıyı konum servislerini açmaya yönlendirin
      return Future.error('Konum servisi kapalı');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Eğer kullanıcı konum iznini reddederse bir hata döndürün
        return Future.error('Konum izni reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Eğer kullanıcı kalıcı olarak konum izni reddederse yönlendirme yapabilirsiniz
      return Future.error(
        'Kalıcı olarak konum izni reddedildi - ayarlardan düzeltebilirsiniz',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
