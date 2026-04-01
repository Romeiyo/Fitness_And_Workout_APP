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

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 2;
  
  final List<Widget> _screens = [
    const BmiCalculator(),
    const MyExercisesPageWrapper(),
    const HomePage(),
    const ExerciseSearchScreen(),
    const OutdoorWorkoutScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
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
          type: BottomNavigationBarType.fixed,
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

class MyExercisesPageWrapper extends StatelessWidget {
  const MyExercisesPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MyExercisesPage(
      onAddExercise: () async {
        final result = await context.pushRoute<Exercise?>(
          AppRoute.addExercise,
        );
        
        if (result != null && context.mounted) {
          await context.read<RoutineProvider>().addExercise(result);
          
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