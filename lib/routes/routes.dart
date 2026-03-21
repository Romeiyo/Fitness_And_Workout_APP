import 'package:fitness_app/pages/bmi_calculator.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String homepage = '/';
  static const String bmiCalculator = '/bmi_calculator';

  static Route<dynamic> generateRoute(RouteSettings rSettings) {
    switch (rSettings.name) {
      case homepage:
        return MaterialPageRoute(
            builder: (context) => const HomePage()
        );
      case bmiCalculator:
        return MaterialPageRoute(builder: (context) => const BmiCalculator()
        );

      default:
        throw const FormatException('Route not found! Check routes again');
    }
  }
}