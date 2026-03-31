import 'package:fitness_app/domain/profile_provider.dart';
import 'package:fitness_app/presentation/pages/exercise_list_screen.dart';
import 'package:fitness_app/presentation/widgets/workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String appName = "Fitness & Workout Tracker";

  final List<Map<String, dynamic>> workoutCategories = [
    {
      'exercise': 'Aerobic Exercises',
      'image': 'assets/aerobic.jpg',
      'color': Colors.orange,
      'icon': Icons.directions_run,
    },
    {
      'exercise': 'Balance Exercises',
      'image': 'assets/balance.jpg',
      'color': Colors.purple,
      'icon': Icons.accessibility_new,
    },
    {
      'exercise': 'Cardio Exercises',
      'image': 'assets/cardio.jpg',
      'color': Colors.red,
      'icon': Icons.favorite,
    },
    {
      'exercise': 'Flexibility Exercises',
      'image': 'assets/flexibility.jpg',
      'color': Colors.green,
      'icon': Icons.self_improvement,
    },
    {
      'exercise': 'Mobility Training',
      'image': 'assets/mobility.jpg',
      'color': Colors.teal,
      'icon': Icons.airline_seat_recline_normal,
    },
    {
      'exercise': 'Strength Workout',
      'image': 'assets/strength.jpg',
      'color': Colors.blue,
      'icon': Icons.fitness_center,
    },
    {
      'exercise': 'Stretching Exercises',
      'image': 'assets/stretching.jpg',
      'color': Colors.lightGreen,
      'icon': Icons.linear_scale,
    },
    {
      'exercise': 'Warm-Up Exercises',
      'image': 'assets/warmup.jpg',
      'color': Colors.amber,
      'icon': Icons.whatshot,
    },
    {
      'exercise': 'Yoga Exercises',
      'image': 'assets/yoga.jpg',
      'color': Colors.indigo,
      'icon': Icons.spa,
    },
  ];

  // Future<void> _addCustomExercise() async {
  //   final result = await context.pushRoute<Exercise?>(
  //     AppRoute.addExercise,
  //   );

  //   if (result != null && mounted) {
  //     await context.read<RoutineProvider>().addExercise(result);
      
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${result.name} added successfully!'),
  //         backgroundColor: Colors.green,
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

  String _getGreeting(String name) {
    if (name == 'Guest' || name.isEmpty) {
      return 'Welcome!';
    }
    return 'Welcome back, $name!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreenAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(appName),
        leading: const Icon(Icons.fitness_center),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.lightGreen.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _getGreeting(profileProvider.name),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (profileProvider.weightGoal > 0) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.flag, color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                'Goal: ${profileProvider.weightGoal.toStringAsFixed(1)} ${profileProvider.weightUnit}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/day.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Featured Workout of the Day',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Colors.white70,
                          ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Featured Workout of the Day',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.width * 0.01,
                    right: MediaQuery.of(context).size.width * 0.02,
                    child: FloatingActionButton.small(
                      onPressed: () {},
                      child: const Text('Start'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Workout Categories'),
                Text('${workoutCategories.length} Categories'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 4;
                  } else if (constraints.maxWidth >= 600) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount = 2;
                  }

                  return GridView.builder(
                    itemCount: workoutCategories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final category = workoutCategories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseListScreen(
                                categoryName: category['exercise'],
                                themeColor: category['color'],
                                iconData: category['icon'],
                              ),
                            ),
                          );
                        },
                        child: WorkoutTile(
                          exercise: category['exercise'],
                          image: category['image'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}