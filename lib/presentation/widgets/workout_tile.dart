import 'package:flutter/material.dart';

/// Simple workout tile widget without favorite button
/// Used on homepage to display workout categories
class WorkoutTile extends StatelessWidget {
  final String exercise;  // Name of the exercise/workout category
  final String image;     // Path to image asset

  const WorkoutTile({
    super.key,
    required this.exercise,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Exercise name with stroke effect for readability
          Stack(
            children: [
              // Stroke text (outline)
              Text(
                exercise,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.white,
                ),
              ),
              // Filled text on top
              Text(
                  exercise,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}