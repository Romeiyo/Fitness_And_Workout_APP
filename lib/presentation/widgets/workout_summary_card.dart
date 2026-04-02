import 'package:flutter/material.dart';

/// Widget displaying workout summary after completion
/// Shows time, distance, pace, and provides option to start new workout
class WorkoutSummaryCard extends StatelessWidget {
  final String formattedTime;      // Formatted elapsed time (e.g., "15:30")
  final String formattedDistance;  // Formatted distance (e.g., "5.2 km")
  final String formattedPace;      // Formatted pace (e.g., "5:30 min/km")
  final VoidCallback onNewWorkout; // Callback to start a new workout
  
  const WorkoutSummaryCard({
    super.key,
    required this.formattedTime,
    required this.formattedDistance,
    required this.formattedPace,
    required this.onNewWorkout,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const Text(
            'Workout Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // Time stat row
          _buildStatRow(Icons.timer, 'Total Time', formattedTime, Colors.blue),
          const Divider(),
          
          // Distance stat row
          _buildStatRow(Icons.straighten, 'Total Distance', formattedDistance, Colors.green),
          const Divider(),
          
          // Pace stat row
          _buildStatRow(Icons.speed, 'Average Pace', formattedPace, Colors.purple),
          
          const SizedBox(height: 24),
          
          // New Workout button
          ElevatedButton(
            onPressed: onNewWorkout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'New Workout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Helper widget to build a stat row with icon, label, and value
  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}