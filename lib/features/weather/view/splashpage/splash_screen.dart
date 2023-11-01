import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mart_tech_test/features/weather/view/homepage/homepage_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash-screen.json', fit: BoxFit.fill),
      splashIconSize: 1000,
      nextScreen: const HomePage(),
      duration: 2500,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
