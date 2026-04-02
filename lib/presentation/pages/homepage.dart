import 'package:fitness_app/domain/auth_provider.dart';
import 'package:fitness_app/domain/profile_provider.dart';
import 'package:fitness_app/presentation/widgets/workout_tile.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home page displaying workout categories and user greeting
/// This is the main landing screen after login
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String appName = "Fitness & Workout Tracker";

  /// List of workout categories with their associated assets
  /// Each category has a name, image path, color, and icon
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Gradient background for visual appeal
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
        actions: [
          // Settings button - navigates to profile/settings screen
          IconButton(
            onPressed: () {
              context.pushRoute(AppRoute.settings);
            }, 
            icon: const Icon(Icons.settings),
            tooltip: "Settings & Profile",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User greeting and profile summary card
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                      // Welcome message with user's display name
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Welcome, ${authProvider.displayName}!',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Display weight goal if set
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
            
            // Featured workout of the day banner
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
                  // Text with stroke effect for readability
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
                  // Start button overlay
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
            
            // Workout categories header with count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Workout Categories'),
                Text('${workoutCategories.length} Categories'),
              ],
            ),
            const SizedBox(height: 20),
            
            // Grid of workout categories
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive grid based on screen width
                  int crossAxisCount;
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 4;  // Large screens: 4 columns
                  } else if (constraints.maxWidth >= 600) {
                    crossAxisCount = 3;  // Medium screens: 3 columns
                  } else {
                    crossAxisCount = 2;  // Small screens: 2 columns
                  }

                  return GridView.builder(
                    itemCount: workoutCategories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,  // Taller than wide
                    ),
                    itemBuilder: (context, index) {
                      final category = workoutCategories[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to exercise list for this category
                          context.pushRouteWithArgs(
                            AppRoute.exerciseList, 
                            ExerciseListArgs(
                              categoryName: category['exercise'], 
                              themeColor: category['color'], 
                              iconData: category['icon'],
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