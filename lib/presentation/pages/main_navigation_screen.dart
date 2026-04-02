import 'package:fitness_app/domain/routine_provider.dart';
import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/presentation/pages/bmi_calculator.dart';
import 'package:fitness_app/presentation/pages/outdoor_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/presentation/pages/homepage.dart';
import 'package:fitness_app/presentation/pages/my_exercises_page.dart';
import 'package:fitness_app/presentation/pages/exercise_search_screen.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:provider/provider.dart';

/// Main navigation screen with bottom navigation bar
/// Contains all main app screens and allows switching between them
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Current selected tab index (default is Home at index 2)
  int _currentIndex = 2;
  
  // List of screens corresponding to each tab
  final List<Widget> _screens = [
    const BmiCalculator(),           // BMI Calculator tab
    const MyExercisesPageWrapper(),  // My Exercises tab
    const HomePage(),                // Home tab (default)
    const ExerciseSearchScreen(),    // Search Exercises tab
    const OutdoorWorkoutScreen(),    // Outdoor Run tab
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display current selected screen
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        // Add shadow to bottom navigation bar
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,  // Allows more than 3 items
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'BMI Calculator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'My Exercises',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: 'Outdoor Run',
            ),
          ],
        ),
      ),
    );
  }
}

/// Wrapper widget for MyExercisesPage that handles adding exercises
/// Separates the navigation logic from the page widget
class MyExercisesPageWrapper extends StatelessWidget {
  const MyExercisesPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MyExercisesPage(
      onAddExercise: () async {
        // Navigate to add exercise screen and wait for result
        final result = await context.pushRoute<Exercise?>(
          AppRoute.addExercise,
        );
        
        // If user added an exercise, save it to the routine provider
        if (result != null && context.mounted) {
          await context.read<RoutineProvider>().addExercise(result);
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${result.name} added to your routine!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}