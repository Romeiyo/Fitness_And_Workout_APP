class ApiExercise {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;

  const ApiExercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory ApiExercise.fromJson(Map<String, dynamic> json) {
    return ApiExercise(
      name: json['name'] as String? ?? 'Unknown Exercise',
      type: json['type'] as String? ?? '',
      muscle: json['muscle'] as String? ?? '',
      equipment: json['equipment'] as String? ?? 'None',
      difficulty: json['difficulty'] as String? ?? 'Not specified',
      instructions: json['instructions'] as String? ?? 'No instructions available.',
    );
  }
}