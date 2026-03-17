import 'package:fitness_app/pages/homepage.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String homepage = '/';

  static Route<dynamic> generateRoute(RouteSettings rSettings) {
    switch (rSettings.name) {
      case homepage:
        return MaterialPageRoute(
            builder: (context) => const HomePage()
        );

      default:
        throw const FormatException('Route not found! Check routes again');
    }
  }
}