/// Model representing an exercise from the external API Ninjas database
/// Contains detailed information about exercises including instructions and equipment
class ApiExercise {
  // Basic exercise information
  final String name;           // Name of the exercise (e.g., "Bench Press")
  final String type;           // Type of exercise (e.g., "Strength", "Cardio")
  final String muscle;         // Primary muscle group targeted
  final String equipment;      // Equipment needed (e.g., "Barbell", "Bodyweight")
  final String difficulty;     // Difficulty level (e.g., "Beginner", "Intermediate")
  final String instructions;   // Step-by-step instructions for performing exercise

  /// Constructor with required fields
  const ApiExercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  /// Factory constructor to create ApiExercise from JSON data
  /// Handles null values gracefully with fallback defaults
  /// @param json - Map containing exercise data from API
  /// @returns ApiExercise instance
  factory ApiExercise.fromJson(Map<String, dynamic> json) {
    return ApiExercise(
      // Use provided value or default if null
      name: json['name'] as String? ?? 'Unknown Exercise',
      type: json['type'] as String? ?? '',
      muscle: json['muscle'] as String? ?? '',
      equipment: json['equipment'] as String? ?? 'None',
      difficulty: json['difficulty'] as String? ?? 'Not specified',
      instructions: json['instructions'] as String? ?? 'No instructions available.',
    );
  }
}