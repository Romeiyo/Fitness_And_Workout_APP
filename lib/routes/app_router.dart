import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/pages/exercise_detail_screen.dart';
import 'package:fitness_app/pages/exercise_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/pages/bmi_calculator.dart';
import 'package:fitness_app/pages/add_exercise_screen.dart';
import 'package:fitness_app/pages/my_exercises_page.dart';

class ExerciseListArgs {
  final String categoryName;
  final Color themeColor;
  final IconData iconData;

  const ExerciseListArgs({
    required this.categoryName,
    required this.themeColor,
    required this.iconData,
  });
}

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
    required this.weight,
  });
}

class MyExercisesArgs {
  final VoidCallback onAddExercise;

  const MyExercisesArgs({
    required this.onAddExercise,
  });
}

enum AppRoute<T> {
  home<void>(),
  bmiCalculator<void>(),
  addExercise<Exercise?>(),
  
  exerciseList<ExerciseListArgs>(),
  exerciseDetail<ExerciseDetailArgs>(),
  
  myExercises<MyExercisesArgs>();

  const AppRoute();

  Route<dynamic> route(T args) {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => switch (this) {
        AppRoute.home => const HomePage(),
        AppRoute.bmiCalculator => const BmiCalculator(),
        AppRoute.addExercise => const AddExerciseScreen(),
        AppRoute.myExercises => MyExercisesPage(
          onAddExercise: (args as MyExercisesArgs).onAddExercise,
        ),
        AppRoute.exerciseList => ExerciseListScreen(
          categoryName: (args as ExerciseListArgs).categoryName,
          themeColor: (args as ExerciseListArgs).themeColor,
          iconData: (args as ExerciseListArgs).iconData,
        ),
        AppRoute.exerciseDetail => ExerciseDetailScreen(
          exerciseName: (args as ExerciseDetailArgs).exerciseName,
          muscleGroup: (args as ExerciseDetailArgs).muscleGroup,
          sets: (args as ExerciseDetailArgs).sets,
          reps: (args as ExerciseDetailArgs).reps,
          weight: (args as ExerciseDetailArgs).weight,
        ),
      },
    );
  }
}

extension AppNavigator on NavigatorState {
  Future<R?> pushRoute<R>(AppRoute<void> route) {
    return push(route.route(null)).then((result) => result as R?);
  }

  Future<T?> pushRouteWithArgs<T>(AppRoute<T> route, T args) {
    return push<T?>(route.route(args) as Route<T?>);
  }
}