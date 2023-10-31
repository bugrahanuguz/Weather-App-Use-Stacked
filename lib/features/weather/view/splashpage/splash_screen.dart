import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:mart_tech_test/core/locator.dart';
import 'package:mart_tech_test/core/services/location_service.dart';
import 'package:mart_tech_test/features/weather/view/homepage/homepage_view.dart';
import 'package:mart_tech_test/features/weather/viewmodels/weather_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    LocationService().getCurrentLocation;
    onStart();
  }

  Future onStart() async {
    WeatherViewModel viewModel = locator<WeatherViewModel>();
    await viewModel.getLocationAndFetchForecast();
    Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherViewModel>.reactive(
      viewModelBuilder: () => WeatherViewModel(),
      onModelReady: (model) => model.initialSetup(),
      builder: (context, model, child) => AnimatedSplashScreen(
        splash: Lottie.asset('assets/splash-screen.json', fit: BoxFit.fill),
        splashIconSize: 1000,
        nextScreen: HomePage(),
        duration: 3500,
        animationDuration: const Duration(seconds: 2),
      ),
    );
  }
}
