/// Model representing a user-created exercise
/// Used for custom exercises added by users and saved in routines
class Exercise {
  // Unique identifier for the exercise (usually timestamp-based)
  final String id;
  
  // Exercise metadata
  final String name;           // Exercise name (e.g., "Bench Press")
  final String muscleGroup;    // Targeted muscle group
  final int sets;              // Number of sets to perform
  final int reps;              // Number of repetitions per set
  final double weight;         // Weight used in kilograms
  final String? image;         // Optional image asset path

  /// Constructor with required fields
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.weight,
    this.image,
  });

  /// Calculates total volume of the exercise
  /// Volume = Sets × Reps × Weight (a measure of total work done)
  double get volume => sets * reps * weight;

  /// Converts Exercise object to JSON for storage
  /// @returns Map containing all exercise data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'image': image,
    };
  }

  /// Factory constructor to create Exercise from JSON
  /// @param json - Map containing stored exercise data
  /// @returns Exercise instance
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroup: json['muscleGroup'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: json['weight'] as double,
      image: json['image'] as String?,
    );
  }

  /// Creates a copy of the exercise with optional updated fields
  /// Useful for immutable updates
  Exercise copyWith({
    String? id,
    String? name,
    String? muscleGroup,
    int? sets,
    int? reps,
    double? weight,
    String? image,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      image: image ?? this.image,
    );
  }

  /// Equality operator - exercises are equal if they have the same ID
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Exercise) return false;
    return id == other.id;
  }

  /// Hash code based on ID for efficient collection operations
  @override
  int get hashCode => id.hashCode;
}