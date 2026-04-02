import 'package:flutter/material.dart';

/// Reusable widget for displaying exercise metrics
/// Used in exercise detail screen to show sets, reps, weight, etc.
class MetricCard extends StatelessWidget {
  final String title;        // Metric title (e.g., "SETS")
  final String value;        // Metric value (e.g., "3")
  final IconData icon;       // Icon representing the metric
  final Color color;         // Color theme for this metric
  final String? suffixText;  // Optional suffix (e.g., "kg", "reps")
  
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.suffixText,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // Background color with opacity for visual depth
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Icon in the metric's color
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          // Title text
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          // Value with optional suffix
          Text(
            suffixText != null ? '$value $suffixText' : value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}