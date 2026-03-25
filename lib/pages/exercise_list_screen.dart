import 'package:flutter/material.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/widgets/workout_tile.dart';

class ExerciseListScreen extends StatelessWidget {
  final String categoryName;
  final Color themeColor;
  final IconData iconData;
  
  const ExerciseListScreen({
    super.key,
    required this.categoryName,
    required this.themeColor,
    required this.iconData,
  });
  
  // Calculate foreground color based on background brightness
  Color _getForegroundColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
  
  // Hardcoded exercises for each category
  List<Map<String, dynamic>> _getExercisesForCategory() {
    switch (categoryName.toLowerCase()) {
      case 'cardio exercises':
        return [
          {
            'name': 'Running', 
            'muscleGroup': 'Legs', 
            'sets': 3, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/cardio.jpg',
          },
          {
            'name': 'Jumping Jacks', 
            'muscleGroup': 'Full Body', 
            'sets': 3, 
            'reps': 20, 
            'weight': 0.0,
            'image': 'assets/cardio.jpg',
          },
          {
            'name': 'Burpees', 
            'muscleGroup': 'Full Body', 
            'sets': 3, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/cardio.jpg',
          },
          {
            'name': 'High Knees', 
            'muscleGroup': 'Legs', 
            'sets': 3, 
            'reps': 30, 
            'weight': 0.0,
            'image': 'assets/cardio.jpg',
          },
        ];
      case 'strength workout':
        return [
          {
            'name': 'Push-ups', 
            'muscleGroup': 'Chest', 
            'sets': 3, 
            'reps': 12, 
            'weight': 0.0,
            'image': 'assets/strength.jpg',
          },
          {
            'name': 'Squats', 
            'muscleGroup': 'Legs', 
            'sets': 3, 
            'reps': 15, 
            'weight': 0.0,
            'image': 'assets/strength.jpg',
          },
          {
            'name': 'Pull-ups', 
            'muscleGroup': 'Back', 
            'sets': 3, 
            'reps': 8, 
            'weight': 0.0,
            'image': 'assets/strength.jpg',
          },
          {
            'name': 'Dumbbell Press', 
            'muscleGroup': 'Shoulders', 
            'sets': 3, 
            'reps': 10, 
            'weight': 15.0,
            'image': 'assets/strength.jpg',
          },
        ];
      case 'flexibility exercises':
        return [
          {
            'name': 'Forward Fold', 
            'muscleGroup': 'Hamstrings', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/flexibility.jpg',
          },
          {
            'name': 'Cat-Cow Stretch', 
            'muscleGroup': 'Back', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/flexibility.jpg',
          },
          {
            'name': 'Butterfly Stretch', 
            'muscleGroup': 'Hips', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/flexibility.jpg',
          },
          {
            'name': 'Triceps Stretch', 
            'muscleGroup': 'Arms', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/flexibility.jpg',
          },
        ];
      case 'aerobic exercises':
        return [
          {
            'name': 'Jump Rope', 
            'muscleGroup': 'Full Body', 
            'sets': 3, 
            'reps': 50, 
            'weight': 0.0,
            'image': 'assets/aerobic.jpg',
          },
          {
            'name': 'Mountain Climbers', 
            'muscleGroup': 'Core', 
            'sets': 3, 
            'reps': 20, 
            'weight': 0.0,
            'image': 'assets/aerobic.jpg',
          },
          {
            'name': 'Step-ups', 
            'muscleGroup': 'Legs', 
            'sets': 3, 
            'reps': 15, 
            'weight': 0.0,
            'image': 'assets/aerobic.jpg',
          },
          {
            'name': 'Dancing', 
            'muscleGroup': 'Full Body', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/aerobic.jpg',
          },
        ];
      case 'balance exercises':
        return [
          {
            'name': 'Single Leg Stand', 
            'muscleGroup': 'Legs', 
            'sets': 2, 
            'reps': 3, 
            'weight': 0.0,
            'image': 'assets/balance.jpg',
          },
          {
            'name': 'Tree Pose', 
            'muscleGroup': 'Legs', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/balance.jpg',
          },
          {
            'name': 'Heel-to-Toe Walk', 
            'muscleGroup': 'Legs', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/balance.jpg',
          },
          {
            'name': 'Warrior III', 
            'muscleGroup': 'Core', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/balance.jpg',
          },
        ];
      case 'mobility training':
        return [
          {
            'name': 'Hip Circles', 
            'muscleGroup': 'Hips', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/mobility.jpg',
          },
          {
            'name': 'Arm Swings', 
            'muscleGroup': 'Shoulders', 
            'sets': 2, 
            'reps': 15, 
            'weight': 0.0,
            'image': 'assets/mobility.jpg',
          },
          {
            'name': 'Cat-Camel', 
            'muscleGroup': 'Spine', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/mobility.jpg',
          },
          {
            'name': 'World\'s Greatest Stretch', 
            'muscleGroup': 'Full Body', 
            'sets': 2, 
            'reps': 5, 
            'weight': 0.0,
            'image': 'assets/mobility.jpg',
          },
        ];
      case 'stretching exercises':
        return [
          {
            'name': 'Hamstring Stretch', 
            'muscleGroup': 'Hamstrings', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/stretching.jpg',
          },
          {
            'name': 'Quad Stretch', 
            'muscleGroup': 'Quads', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/stretching.jpg',
          },
          {
            'name': 'Shoulder Stretch', 
            'muscleGroup': 'Shoulders', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/stretching.jpg',
          },
          {
            'name': 'Child\'s Pose', 
            'muscleGroup': 'Back', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/stretching.jpg',
          },
        ];
      case 'warm-up exercises':
        return [
          {
            'name': 'Arm Circles', 
            'muscleGroup': 'Shoulders', 
            'sets': 2, 
            'reps': 15, 
            'weight': 0.0,
            'image': 'assets/warmup.jpg',
          },
          {
            'name': 'Leg Swings', 
            'muscleGroup': 'Legs', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/warmup.jpg',
          },
          {
            'name': 'Torso Twists', 
            'muscleGroup': 'Core', 
            'sets': 2, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/warmup.jpg',
          },
          {
            'name': 'Neck Rolls', 
            'muscleGroup': 'Neck', 
            'sets': 2, 
            'reps': 5, 
            'weight': 0.0,
            'image': 'assets/warmup.jpg',
          },
        ];
      case 'yoga exercises':
        return [
          {
            'name': 'Downward Dog', 
            'muscleGroup': 'Full Body', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/yoga.jpg',
          },
          {
            'name': 'Cobra Pose', 
            'muscleGroup': 'Back', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/yoga.jpg',
          },
          {
            'name': 'Warrior II', 
            'muscleGroup': 'Legs', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/yoga.jpg',
          },
          {
            'name': 'Tree Pose', 
            'muscleGroup': 'Balance', 
            'sets': 2, 
            'reps': 1, 
            'weight': 0.0,
            'image': 'assets/yoga.jpg',
          },
        ];
      default:
        return [
          {
            'name': 'Basic Exercise 1', 
            'muscleGroup': 'General', 
            'sets': 3, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/day.jpg',
          },
          {
            'name': 'Basic Exercise 2', 
            'muscleGroup': 'General', 
            'sets': 3, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/day.jpg',
          },
          {
            'name': 'Basic Exercise 3', 
            'muscleGroup': 'General', 
            'sets': 3, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/day.jpg',
          },
          {
            'name': 'Basic Exercise 4', 
            'muscleGroup': 'General', 
            'sets': 3, 
            'reps': 10, 
            'weight': 0.0,
            'image': 'assets/day.jpg',
          },
        ];
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final exercises = _getExercisesForCategory();
    final foregroundColor = _getForegroundColor(themeColor);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Exercises'),
        backgroundColor: themeColor,
        foregroundColor: foregroundColor,
        leading: Icon(iconData, color: foregroundColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category info header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: themeColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(iconData, color: themeColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                        Text(
                          '${exercises.length} exercises available',
                          style: TextStyle(
                            fontSize: 12,
                            color: themeColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth >= 600) {
                    crossAxisCount = 2;
                  } else {
                    crossAxisCount = 2;
                  }
                  
                  return GridView.builder(
                    itemCount: exercises.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return GestureDetector(
                        onTap: () {
                          // Type-safe navigation to exercise detail
                          Navigator.of(context).pushRouteWithArgs(
                            AppRoute.exerciseDetail,
                            ExerciseDetailArgs(
                              exerciseName: exercise['name'],
                              muscleGroup: exercise['muscleGroup'],
                              sets: exercise['sets'],
                              reps: exercise['reps'],
                              weight: exercise['weight'],
                            ),
                          );
                        },
                        child: WorkoutTile(
                          exercise: exercise['name'],
                          image: exercise['image'],
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