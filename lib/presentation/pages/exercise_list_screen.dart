import 'package:fitness_app/domain/routine_provider.dart';
import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/presentation/widgets/workout_favorite.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Screen that displays a list of exercises for a specific workout category
/// Shows a grid of exercises with their images and allows users to save them to their routine
/// Users can tap on an exercise to view detailed information
class ExerciseListScreen extends StatelessWidget {
  // Name of the workout category (e.g., "Cardio Exercises", "Strength Workout")
  final String categoryName;
  
  // Theme color for this category - used for app bar, borders, and highlights
  final Color themeColor;
  
  // Icon representing this category (e.g., running icon for cardio)
  final IconData iconData;
  
  const ExerciseListScreen({
    super.key,
    required this.categoryName,
    required this.themeColor,
    required this.iconData,
  });
  
  /// Determines whether text should be white or black based on background color
  /// Uses theme's brightness estimation to ensure text contrast and readability
  /// @param backgroundColor - The background color to check against
  /// @returns White for dark backgrounds, black for light backgrounds
  Color _getForegroundColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
  
  /// Returns a predefined list of exercises for the current category
  /// Each category has its own set of exercises with appropriate details
  /// @returns List of Exercise objects for the current category
  List<Exercise> _getExercisesForCategory() {
    // Switch on category name (case-insensitive) to return appropriate exercises
    switch (categoryName.toLowerCase()) {
      case 'cardio exercises':
        // Cardio exercises focused on cardiovascular endurance
        // Most have weight=0.0 as they're bodyweight exercises
        return [
          Exercise(
            id: 'cardio_1',
            name: 'Running',
            muscleGroup: 'Legs',
            sets: 3,
            reps: 1,        // Represents one continuous running session
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
        // Strength training exercises that build muscle
        // Some exercises have weight (dumbbell press) while others use bodyweight
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
            weight: 15.0,    // 15kg dumbbells - weighted exercise
            image: 'assets/strength.jpg',
          ),
        ];
        
      case 'flexibility exercises':
        // Flexibility and stretching exercises
        // Lower sets and reps, focused on holding positions
        return [
          Exercise(
            id: 'flex_1',
            name: 'Forward Fold',
            muscleGroup: 'Hamstrings',
            sets: 2,
            reps: 1,         // Hold the stretch
            weight: 0.0,
            image: 'assets/flexibility.jpg',
          ),
          Exercise(
            id: 'flex_2',
            name: 'Cat-Cow Stretch',
            muscleGroup: 'Back',
            sets: 2,
            reps: 10,        // Dynamic movement, 10 repetitions
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
        // Aerobic exercises that elevate heart rate
        // Focus on sustained movement with moderate repetitions
        return [
          Exercise(
            id: 'aerobic_1',
            name: 'Jump Rope',
            muscleGroup: 'Full Body',
            sets: 3,
            reps: 50,        // 50 jumps per set
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
            reps: 1,         // One continuous dancing session
            weight: 0.0,
            image: 'assets/aerobic.jpg',
          ),
        ];
        
      case 'balance exercises':
        // Balance training exercises
        // Lower reps with focus on stability and control
        return [
          Exercise(
            id: 'balance_1',
            name: 'Single Leg Stand',
            muscleGroup: 'Legs',
            sets: 2,
            reps: 3,         // 3 holds per leg
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
            reps: 10,        // 10 steps
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
        // Mobility exercises to improve range of motion
        // Dynamic movements with moderate repetitions
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
            reps: 5,         // 5 repetitions per side
            weight: 0.0,
            image: 'assets/mobility.jpg',
          ),
        ];
        
      case 'stretching exercises':
        // Static stretching exercises for flexibility
        // Low reps, held positions
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
        // Warm-up exercises to prepare body for workout
        // Dynamic movements with controlled repetitions
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
        // Yoga poses for flexibility and mindfulness
        // Held positions with focus on breathing
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
        // Fallback exercises for any undefined categories
        // Provides basic exercises with general muscle group targeting
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
    // Get the list of exercises for this category
    final exercises = _getExercisesForCategory();
    
    // Determine if text should be light or dark based on theme color
    final foregroundColor = _getForegroundColor(themeColor);
    
    return Scaffold(
      appBar: AppBar(
        // Dynamic title showing category name
        title: Text('$categoryName Exercises'),
        backgroundColor: themeColor,
        foregroundColor: foregroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        // Note: The favorite button in actions is commented out
        // Could be implemented to show user's saved exercises
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.favorite),
        //     tooltip: 'My Saved Exercises',
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category information card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // Semi-transparent background in theme color
                color: themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: themeColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  // Category icon
                  Icon(iconData, color: themeColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category name
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                        // Exercise count
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
            
            // Grid of exercises
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive grid layout based on screen width
                  // Adjust number of columns for different screen sizes
                  int crossAxisCount;
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 3;  // Large screens: 3 columns
                  } else if (constraints.maxWidth >= 600) {
                    crossAxisCount = 2;  // Medium screens: 2 columns
                  } else {
                    crossAxisCount = 2;  // Small screens: 2 columns
                  }
                  
                  return GridView.builder(
                    itemCount: exercises.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,  // Make tiles slightly taller than wide
                    ),
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      
                      // Consumer listens to RoutineProvider for saved state
                      // Rebuilds only when saved exercises change
                      return Consumer<RoutineProvider>(
                        builder: (context, provider, child) {
                          // Check if this exercise is already saved
                          final isSaved = provider.isSaved(exercise.id);
                          
                          return GestureDetector(
                            onTap: () {
                              // Navigate to exercise detail screen with exercise data
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
                              // Use exercise image or fallback to default
                              image: exercise.image ?? 'assets/day.jpg',
                              isSaved: isSaved,
                              onFavoriteToggle: () async {
                                // Toggle save/unsave based on current state
                                if (isSaved) {
                                  // Remove from saved exercises
                                  provider.removeExercise(exercise.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Removed ${exercise.name} from saved'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                } else {
                                  // Add to saved exercises
                                  await provider.addExercise(exercise);
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