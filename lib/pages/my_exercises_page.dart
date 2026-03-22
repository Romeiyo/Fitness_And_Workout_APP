import 'package:flutter/material.dart';

class MyExercisesPage extends StatelessWidget {
  final List<Map<String, dynamic>> exercises;
  final Function(Map<String, dynamic>) onDeleteExercise;
  final VoidCallback onAddExercise;
  
  const MyExercisesPage({
    super.key,
    required this.exercises,
    required this.onDeleteExercise,
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Custom Exercises'),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            onPressed: onAddExercise,
            icon: const Icon(Icons.add),
            tooltip: 'Add Exercise',
          ),
        ],
      ),
      body: exercises.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Exercises Added',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first custom exercise',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: onAddExercise,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Exercise'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                final totalVolume = exercise['sets'] * exercise['reps'] * (exercise['weight'] as double).toInt();
                final muscleGroup = exercise['muscleGroup'] as String?;
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
                            color: iconColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${exercise['sets']} sets × ${exercise['reps']} reps × ${exercise['weight']} kg',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total Volume: $totalVolume kg',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: iconColor,
                                ),
                              ),
                              if (muscleGroup != null) ...[
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
                          onPressed: () => onDeleteExercise(exercise),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}