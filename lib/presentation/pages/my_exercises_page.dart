import 'package:fitness_app/domain/routine_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyExercisesPage extends StatelessWidget {
  final VoidCallback onAddExercise;
  
  const MyExercisesPage({
    super.key,
    required this.onAddExercise,
  });
  
  IconData _getExerciseIcon(String? muscleGroup) {
    switch (muscleGroup) {
      case 'Chest':
        return Icons.fitness_center;
      case 'Back':
        return Icons.accessibility_new;
      case 'Legs':
        return Icons.directions_walk;
      case 'Arms':
        return Icons.handshake;
      case 'Shoulders':
        return Icons.airline_seat_recline_extra;
      case 'Core':
        return Icons.rectangle;
      default:
        return Icons.fitness_center;
    }
  }
  
  Color _getExerciseColor(String? muscleGroup) {
    switch (muscleGroup) {
      case 'Chest':
        return Colors.red;
      case 'Back':
        return Colors.green;
      case 'Legs':
        return Colors.orange;
      case 'Arms':
        return Colors.blue;
      case 'Shoulders':
        return Colors.purple;
      case 'Core':
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }
  
  void _showClearAllDialog(BuildContext context, RoutineProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Exercises'),
        content: const Text(
          'Are you sure you want to remove all saved exercises? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await provider.clearAllExercises();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All exercises cleared'),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Saved Exercises'),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            onPressed: onAddExercise,
            icon: const Icon(Icons.add),
            tooltip: 'Add Exercise',
          ),
          Consumer<RoutineProvider>(
            builder: (context, provider, child) {
              if (provider.exerciseCount > 0) {
                return IconButton(
                  onPressed: () => _showClearAllDialog(context, provider),
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: 'Clear All',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<RoutineProvider>(
        builder: (context, provider, child) {
          final exercises = provider.savedExercises;
          
          if (exercises.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Saved Exercises',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart button on any exercise to save it here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: onAddExercise,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Custom Exercise'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              final totalVolume = exercise.volume;
              final muscleGroup = exercise.muscleGroup;
              final iconColor = _getExerciseColor(muscleGroup);
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getExerciseIcon(muscleGroup),
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${exercise.sets} sets x ${exercise.reps} reps x ${exercise.weight.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total Volume: ${totalVolume.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: iconColor,
                              ),
                            ),
                            if (muscleGroup.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Target: $muscleGroup',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async {
                          await provider.removeExercise(exercise.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed ${exercise.name}'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}