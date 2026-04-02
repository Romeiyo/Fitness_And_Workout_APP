import 'package:fitness_app/presentation/pages/auth_gate.dart';
import 'package:fitness_app/presentation/pages/exercise_detail_screen.dart';
import 'package:fitness_app/presentation/pages/exercise_list_screen.dart';
import 'package:fitness_app/presentation/pages/exercise_search_screen.dart';
import 'package:fitness_app/presentation/pages/login_screen.dart';
import 'package:fitness_app/presentation/pages/main_navigation_screen.dart';
import 'package:fitness_app/presentation/pages/settings_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/presentation/pages/homepage.dart';
import 'package:fitness_app/presentation/pages/bmi_calculator.dart';
import 'package:fitness_app/presentation/pages/add_exercise_screen.dart';
import 'package:fitness_app/presentation/pages/my_exercises_page.dart';

/// Global navigator key for accessing navigation from anywhere
/// Useful for navigation outside of BuildContext
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Arguments class for ExerciseListScreen
/// Contains data needed to display a specific exercise category
class ExerciseListArgs {
  final String categoryName;   // Name of the category (e.g., "Cardio Exercises")
  final Color themeColor;       // Color theme for the category
  final IconData iconData;      // Icon representing the category

  const ExerciseListArgs({
    required this.categoryName,
    required this.themeColor,
    required this.iconData,
  });
}

/// Arguments class for ExerciseDetailScreen
/// Contains data needed to display exercise details
class ExerciseDetailArgs {
  final String exerciseName;   // Name of the exercise
  final String muscleGroup;     // Targeted muscle group
  final int sets;               // Number of sets
  final int reps;               // Number of reps
  final double weight;          // Weight used

  const ExerciseDetailArgs({
    required this.exerciseName,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}

/// Arguments class for MyExercisesPage
/// Contains callback for adding new exercises
class MyExercisesArgs {
  final VoidCallback onAddExercise;  // Callback when user wants to add exercise

  const MyExercisesArgs({
    required this.onAddExercise,
  });
}

/// Placeholder for routes that don't need arguments
class NoArgs {
  const NoArgs();
}

/// Type-safe route definitions with generics
/// Each route can have typed arguments
enum AppRoute<T> {
  authGate<NoArgs>(),
  login<NoArgs>(),
  home<NoArgs>(),
  mainNavigationScreen<NoArgs>(),
  bmiCalculator<NoArgs>(),
  addExercise<NoArgs>(),
  settings<NoArgs>(),
  exerciseList<ExerciseListArgs>(),
  exerciseDetail<ExerciseDetailArgs>(),
  myExercises<MyExercisesArgs>(),
  exerciseSearch<NoArgs>();

  const AppRoute();

  /// Creates a MaterialPageRoute for this route with given arguments
  Route<dynamic> route(T args) {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),  // Uses enum name as route name
      builder: (context) => switch (this) {
        // Routes without arguments
        AppRoute.authGate => const AuthGate(),
        AppRoute.login => const LoginScreen(),
        AppRoute.home => const HomePage(),
        AppRoute.mainNavigationScreen => MainNavigationScreen(),
        AppRoute.bmiCalculator => const BmiCalculator(),
        AppRoute.addExercise => const AddExerciseScreen(),
        AppRoute.settings => const SettingsProfileScreen(),
        AppRoute.exerciseSearch => const ExerciseSearchScreen(),
        
        // Routes with arguments - cast to appropriate type
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

/// Navigation extension for NavigatorState
/// Provides type-safe navigation methods
extension AppNavigator on NavigatorState {
  /// Push a route without arguments and return result
  Future<R?> pushRoute<R>(AppRoute<NoArgs> route) {
    return push(route.route(const NoArgs())).then((result) => result as R?);
  }

  /// Push a route with typed arguments
  Future<void> pushRouteWithArgs<T>(AppRoute<T> route, T args) {
    return push(route.route(args));
  }

  /// Push a route and remove all previous routes
  Future<void> pushRouteAndRemoveUntil<R>(AppRoute<NoArgs> route) {
    final navigator = this;
    return navigator.pushAndRemoveUntil(
      route.route(const NoArgs()),
      (r) => false,  // Remove all routes
    );
  }
}

/// Navigation extension for BuildContext
/// Provides convenient navigation methods anywhere with context
extension AppNavigatorContext on BuildContext {
  /// Push a route without arguments and return result
  Future<R?> pushRoute<R>(AppRoute<NoArgs> route) {
    return Navigator.of(this).push(route.route(const NoArgs())).then((result) => result as R?);
  }

  /// Push a route with typed arguments
  Future<void> pushRouteWithArgs<T>(AppRoute<T> route, T args) {
    return Navigator.of(this).push(route.route(args));
  }

  /// Pop the current route with optional result
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Push a route and remove all previous routes
  Future<void> pushRouteAndRemoveUntil<R>(AppRoute<NoArgs> route) {
    return Navigator.of(this).pushAndRemoveUntil(
      route.route(const NoArgs()),
      (route) => false,  // Remove all routes
    );
  }
}