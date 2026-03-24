import 'package:fitness_app/pages/add_exercise_screen.dart';
import 'package:fitness_app/pages/bmi_calculator.dart';
import 'package:fitness_app/pages/exercise_detail_screen.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/pages/my_exercises_page.dart';
import 'package:flutter/material.dart';

//this class supplies the exact data that each screen needs
class ExerciseDetailArgs {
  final String exerciseName;
  final String muscleGroup;
  final int sets;
  final int reps;
  final double weight;

  const ExerciseDetailArgs({
    required this.exerciseName,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.weight
  });
}

enum AppRoute<T> {

  homepage<void>(),
  bmiCalculator<void>(),
  addExercise<void>(),
  myExercises<Map<String, dynamic>?>(),
  exerciseDetail<ExerciseDetailArgs>();

  const AppRoute();

  Route<dynamic> route(T args) {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) {
        switch (this) {
          case AppRoute.homepage:
            const HomePage();

          case AppRoute.bmiCalculator:
            return const BmiCalculator();

          case AppRoute.addExercise:
            return const AddExerciseScreen();
          
          case AppRoute.myExercises:
            final mapArgs = args as Map<String, dynamic>?;
            return MyExercisesPage(
              exercises: mapArgs?['exercises'] ?? [],
              onDeleteExercise: mapArgs?['onDelete'] ?? [],
              onAddExercise: mapArgs?['onAdd'] ?? () {},
              );
          
          case AppRoute.exerciseDetail:
            final detailArgs = args as ExerciseDetailArgs;
            return ExerciseDetailScreen(
              exerciseName: detailArgs.exerciseName,
              muscleGroup: detailArgs.muscleGroup,
              sets: detailArgs.sets,
              reps: detailArgs.reps,
              weight: detailArgs.weight,
            );
        }
      },
    );
  }
}

extension AppNavigator on NavigatorState {
  /// Push a route that takes NO arguments (void routes)
  Future<R?> pushRoute<R>(AppRoute<void> route) {
    return push<R>(route.route(null) as Route<R>);
  }

  /// Push a route that REQUIRES arguments
  Future<R?> pushRouteWithArgs<R, T>(AppRoute<T> route, T args) {
    return push<R>(route.route(args) as Route<R>);
  }
}