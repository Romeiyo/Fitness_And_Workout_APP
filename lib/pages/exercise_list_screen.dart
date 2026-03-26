import 'package:fitness_app/widgets/workout_favorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exercise.dart';
import '../providers/routine_provider.dart';
import '../routes/app_router.dart';

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
  
  Color _getForegroundColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
  
  List<Exercise> _getExercisesForCategory() {
    switch (categoryName.toLowerCase()) {
      case 'cardio exercises':
        return [
          Exercise(
            id: 'cardio_1',
            name: 'Running',
            muscleGroup: 'Legs',
            sets: 3,
            reps: 1,
            weight: 0.0,
            image: 'assets/cardio.jpg',
          ),
          Exercise(
            id: 'cardio_2',
            name: 'Jumping Jacks',
            muscleGroup: 'Full Body',
            sets: 3,
            reps: 20,
            weight: 0.0,
            image: 'assets/cardio.jpg',
          ),
          Exercise(
            id: 'cardio_3',
            name: 'Burpees',
            muscleGroup: 'Full Body',
            sets: 3,
            reps: 10,
            weight: 0.0,
            image: 'assets/cardio.jpg',
          ),
          Exercise(
            id: 'cardio_4',
            name: 'High Knees',
            muscleGroup: 'Legs',
            sets: 3,
            reps: 30,
            weight: 0.0,
            image: 'assets/cardio.jpg',
          ),
        ];
      case 'strength workout':
        return [
          Exercise(
            id: 'strength_1',
            name: 'Push-ups',
            muscleGroup: 'Chest',
            sets: 3,
            reps: 12,
            weight: 0.0,
            image: 'assets/strength.jpg',
          ),
          Exercise(
            id: 'strength_2',
            name: 'Squats',
            muscleGroup: 'Legs',
            sets: 3,
            reps: 15,
            weight: 0.0,
            image: 'assets/strength.jpg',
          ),
          Exercise(
            id: 'strength_3',
            name: 'Pull-ups',
            muscleGroup: 'Back',
            sets: 3,
            reps: 8,
            weight: 0.0,
            image: 'assets/strength.jpg',
          ),
          Exercise(
            id: 'strength_4',
            name: 'Dumbbell Press',
            muscleGroup: 'Shoulders',
            sets: 3,
            reps: 10,
            weight: 15.0,
            image: 'assets/strength.jpg',
          ),
        ];
      case 'flexibility exercises':
        return [
          Exercise(
            id: 'flex_1',
            name: 'Forward Fold',
            muscleGroup: 'Hamstrings',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/flexibility.jpg',
          ),
          Exercise(
            id: 'flex_2',
            name: 'Cat-Cow Stretch',
            muscleGroup: 'Back',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/flexibility.jpg',
          ),
          Exercise(
            id: 'flex_3',
            name: 'Butterfly Stretch',
            muscleGroup: 'Hips',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/flexibility.jpg',
          ),
          Exercise(
            id: 'flex_4',
            name: 'Triceps Stretch',
            muscleGroup: 'Arms',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/flexibility.jpg',
          ),
        ];
      case 'aerobic exercises':
        return [
          Exercise(
            id: 'aerobic_1',
            name: 'Jump Rope',
            muscleGroup: 'Full Body',
            sets: 3,
            reps: 50,
            weight: 0.0,
            image: 'assets/aerobic.jpg',
          ),
          Exercise(
            id: 'aerobic_2',
            name: 'Mountain Climbers',
            muscleGroup: 'Core',
            sets: 3,
            reps: 20,
            weight: 0.0,
            image: 'assets/aerobic.jpg',
          ),
          Exercise(
            id: 'aerobic_3',
            name: 'Step-ups',
            muscleGroup: 'Legs',
            sets: 3,
            reps: 15,
            weight: 0.0,
            image: 'assets/aerobic.jpg',
          ),
          Exercise(
            id: 'aerobic_4',
            name: 'Dancing',
            muscleGroup: 'Full Body',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/aerobic.jpg',
          ),
        ];
      case 'balance exercises':
        return [
          Exercise(
            id: 'balance_1',
            name: 'Single Leg Stand',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 3,
            weight: 0.0,
            image: 'assets/balance.jpg',
          ),
          Exercise(
            id: 'balance_2',
            name: 'Tree Pose',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/balance.jpg',
          ),
          Exercise(
            id: 'balance_3',
            name: 'Heel-to-Toe Walk',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/balance.jpg',
          ),
          Exercise(
            id: 'balance_4',
            name: 'Warrior III',
            muscleGroup: 'Core',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/balance.jpg',
          ),
        ];
      case 'mobility training':
        return [
          Exercise(
            id: 'mobility_1',
            name: 'Hip Circles',
            muscleGroup: 'Hips',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/mobility.jpg',
          ),
          Exercise(
            id: 'mobility_2',
            name: 'Arm Swings',
            muscleGroup: 'Shoulders',
            sets: 2,
            reps: 15,
            weight: 0.0,
            image: 'assets/mobility.jpg',
          ),
          Exercise(
            id: 'mobility_3',
            name: 'Cat-Camel',
            muscleGroup: 'Spine',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/mobility.jpg',
          ),
          Exercise(
            id: 'mobility_4',
            name: 'World\'s Greatest Stretch',
            muscleGroup: 'Full Body',
            sets: 2,
            reps: 5,
            weight: 0.0,
            image: 'assets/mobility.jpg',
          ),
        ];
      case 'stretching exercises':
        return [
          Exercise(
            id: 'stretch_1',
            name: 'Hamstring Stretch',
            muscleGroup: 'Hamstrings',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/stretching.jpg',
          ),
          Exercise(
            id: 'stretch_2',
            name: 'Quad Stretch',
            muscleGroup: 'Quads',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/stretching.jpg',
          ),
          Exercise(
            id: 'stretch_3',
            name: 'Shoulder Stretch',
            muscleGroup: 'Shoulders',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/stretching.jpg',
          ),
          Exercise(
            id: 'stretch_4',
            name: 'Child\'s Pose',
            muscleGroup: 'Back',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/stretching.jpg',
          ),
        ];
      case 'warm-up exercises':
        return [
          Exercise(
            id: 'warmup_1',
            name: 'Arm Circles',
            muscleGroup: 'Shoulders',
            sets: 2,
            reps: 15,
            weight: 0.0,
            image: 'assets/warmup.jpg',
          ),
          Exercise(
            id: 'warmup_2',
            name: 'Leg Swings',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/warmup.jpg',
          ),
          Exercise(
            id: 'warmup_3',
            name: 'Torso Twists',
            muscleGroup: 'Core',
            sets: 2,
            reps: 10,
            weight: 0.0,
            image: 'assets/warmup.jpg',
          ),
          Exercise(
            id: 'warmup_4',
            name: 'Neck Rolls',
            muscleGroup: 'Neck',
            sets: 2,
            reps: 5,
            weight: 0.0,
            image: 'assets/warmup.jpg',
          ),
        ];
      case 'yoga exercises':
        return [
          Exercise(
            id: 'yoga_1',
            name: 'Downward Dog',
            muscleGroup: 'Full Body',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/yoga.jpg',
          ),
          Exercise(
            id: 'yoga_2',
            name: 'Cobra Pose',
            muscleGroup: 'Back',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/yoga.jpg',
          ),
          Exercise(
            id: 'yoga_3',
            name: 'Warrior II',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/yoga.jpg',
          ),
          Exercise(
            id: 'yoga_4',
            name: 'Tree Pose',
            muscleGroup: 'Balance',
            sets: 2,
            reps: 1,
            weight: 0.0,
            image: 'assets/yoga.jpg',
          ),
        ];
      default:
        return [
          Exercise(
            id: 'basic_1',
            name: 'Basic Exercise 1',
            muscleGroup: 'General',
            sets: 3,
            reps: 10,
            weight: 0.0,
            image: 'assets/day.jpg',
          ),
          Exercise(
            id: 'basic_2',
            name: 'Basic Exercise 2',
            muscleGroup: 'General',
            sets: 3,
            reps: 10,
            weight: 0.0,
            image: 'assets/day.jpg',
          ),
          Exercise(
            id: 'basic_3',
            name: 'Basic Exercise 3',
            muscleGroup: 'General',
            sets: 3,
            reps: 10,
            weight: 0.0,
            image: 'assets/day.jpg',
          ),
          Exercise(
            id: 'basic_4',
            name: 'Basic Exercise 4',
            muscleGroup: 'General',
            sets: 3,
            reps: 10,
            weight: 0.0,
            image: 'assets/day.jpg',
          ),
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
        actions: [
          IconButton(
            onPressed: () {
              context.pushRouteWithArgs(
                AppRoute.myExercises,
                MyExercisesArgs(
                  onAddExercise: () {},
                ),
              );
            },
            icon: const Icon(Icons.favorite),
            tooltip: 'My Saved Exercises',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: themeColor.withValues(alpha: 0.3)),
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
                            color: themeColor.withValues(alpha: 0.7),
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
                      return Consumer<RoutineProvider>(
                        builder: (context, provider, child) {
                          final isSaved = provider.isSaved(exercise.id);
                          
                          return GestureDetector(
                            onTap: () {
                              context.pushRouteWithArgs(
                                AppRoute.exerciseDetail,
                                ExerciseDetailArgs(
                                  exerciseName: exercise.name,
                                  muscleGroup: exercise.muscleGroup,
                                  sets: exercise.sets,
                                  reps: exercise.reps,
                                  weight: exercise.weight,
                                ),
                              );
                            },
                            child: WorkoutTileWithFavorite(
                              exercise: exercise.name,
                              image: exercise.image ?? 'assets/day.jpg',
                              isSaved: isSaved,
                              onFavoriteToggle: () {
                                if (isSaved) {
                                  provider.removeExercise(exercise.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Removed ${exercise.name} from saved'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                } else {
                                  provider.addExercise(exercise);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Added ${exercise.name} to saved'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
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
