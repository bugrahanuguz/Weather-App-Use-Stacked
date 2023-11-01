import 'package:flutter/material.dart';
import 'package:mart_tech_test/core/locator.dart';
import 'package:mart_tech_test/core/services/location_service.dart';
import 'package:mart_tech_test/features/weather/view/splashpage/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  LocationService().getCurrentLocation();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const SplashScreen());
  }
}
