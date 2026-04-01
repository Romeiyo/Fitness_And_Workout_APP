import 'package:flutter/material.dart';

class WorkoutSummaryCard extends StatelessWidget {
  final String formattedTime;
  final String formattedDistance;
  final String formattedPace;
  final VoidCallback onNewWorkout;
  
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
          const Text(
            'Workout Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          _buildStatRow(Icons.timer, 'Total Time', formattedTime, Colors.blue),
          const Divider(),
          
          _buildStatRow(Icons.straighten, 'Total Distance', formattedDistance, Colors.green),
          const Divider(),
          
          _buildStatRow(Icons.speed, 'Average Pace', formattedPace, Colors.purple),
          
          const SizedBox(height: 24),
          
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