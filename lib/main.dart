import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/data/api_repository.dart';
import 'package:fitness_app/data/auth_service.dart';
import 'package:fitness_app/data/location_service.dart';
import 'package:fitness_app/data/notification_service.dart';
import 'package:fitness_app/data/profile_repository.dart';
import 'package:fitness_app/data/routine_repository.dart';
import 'package:fitness_app/domain/auth_provider.dart';
import 'package:fitness_app/domain/exercise_search_provider.dart';
import 'package:fitness_app/domain/profile_provider.dart';
import 'package:fitness_app/domain/routine_provider.dart';
import 'package:fitness_app/domain/workout_tracking_provider.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/presentation/pages/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/routes/app_router.dart';

/// Entry point of the application
/// Initializes Firebase and notification services before running the app
void main() async {
  // Ensures that widget binding is initialized before calling async operations
  // Required for using plugins like Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific configuration
  // This connects the app to Firebase services (Auth, Analytics, etc.)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notification system for workout reminders and alerts
  await NotificationService().init();

  // Start the Flutter application with MyApp widget
  runApp(const MyApp());
}

/// Root widget of the application
/// Sets up all providers (state management) and the main MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider allows multiple ChangeNotifier providers to be registered
    // This makes state available throughout the widget tree
    return MultiProvider(
      providers: [
        // AuthProvider manages authentication state (login, register, logout)
        ChangeNotifierProvider(create: (_) => AuthProvider(AuthService()),),
        
        // RoutineProvider manages user's saved workout routines/exercises
        ChangeNotifierProvider(create: (_) => RoutineProvider(RoutineRepository()),),
        
        // ProfileProvider manages user profile data (name, age, preferences)
        ChangeNotifierProvider(create: (_) => ProfileProvider(ProfileRepository()),),
        
        // ExerciseSearchProvider handles searching exercises via API
        ChangeNotifierProvider(create: (_) => ExerciseSearchProvider(ExerciseApiRepository()),),
        
        // WorkoutTrackingProvider manages GPS tracking for outdoor workouts
        ChangeNotifierProvider(create: (_) => WorkoutTrackingProvider(LocationService()),),
      ],
      child: MaterialApp(
        title: 'Fitness App',
        
        // Global navigator key allows navigation from anywhere in the app
        // Useful for navigating without BuildContext
        navigatorKey: navigatorKey,
        
        // Theme configuration with Material Design 3
        theme: ThemeData(
          // ColorScheme generated from a seed color (lightGreenAccent)
          // Creates a cohesive color palette for the entire app
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true, // Enables Material Design 3 features
        ),
        
        // Shows debug banner in development (can be turned off for production)
        debugShowCheckedModeBanner: true,
        
        // Initial screen - AuthGate checks if user is logged in
        // Shows login screen or main app based on auth state
        home: const AuthGate(),
      ),
    );
  }
}