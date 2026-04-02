import 'package:flutter/material.dart';

/// Widget displaying a workout tile with favorite/heart button
/// Used in exercise list screen to show exercises and allow saving
class WorkoutTileWithFavorite extends StatelessWidget {
  final String exercise;          // Name of the exercise
  final String image;             // Path to exercise image asset
  final bool isSaved;             // Whether exercise is saved to favorites
  final VoidCallback onFavoriteToggle; // Callback when heart button is tapped

  const WorkoutTileWithFavorite({
    super.key,
    required this.exercise,
    required this.image,
    required this.isSaved,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Main tile container with background image
        Container(
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
            // Border changes color if exercise is saved
            border: Border.all(
              color: isSaved 
                  ? Colors.green 
                  : colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: isSaved ? 2 : 1,
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
        ),
        // Favorite button positioned in top-right corner
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isSaved ? Icons.favorite : Icons.favorite_border,
                color: isSaved ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}