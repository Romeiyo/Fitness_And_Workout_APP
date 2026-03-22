import 'package:fitness_app/pages/add_exercise_screen.dart';
import 'package:fitness_app/pages/bmi_calculator.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/pages/my_exercises_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String homepage = '/';
  static const String bmiCalculator = '/bmi_calculator';
  static const String addExercise = 'add_exercise';
  static const String myExercise = 'add_exercises';

  static Route<dynamic> generateRoute(RouteSettings rSettings) {
    switch (rSettings.name) {
      case homepage:
        return MaterialPageRoute(
            builder: (context) => const HomePage(),
        );
      case bmiCalculator:
        return MaterialPageRoute(
          builder: (context) => const BmiCalculator(),
        );
      case addExercise:
        return MaterialPageRoute(
          builder: (context) => const AddExerciseScreen(),
          );
      case myExercise:
        final args = rSettings.arguments as Map?;
        return MaterialPageRoute(
          builder: (context) => MyExercisesPage(
            exercises: args?['exercises'] ?? [],
            onDeleteExercise: args?['onDelete'] ?? (_) {}, 
            onAddExercise: args?['onAdd'] ?? () {},
            ),
          );

      default:
        throw const FormatException('Route not found! Check routes again');
    }
  }
}