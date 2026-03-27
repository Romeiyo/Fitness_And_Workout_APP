class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final int sets;
  final int reps;
  final double weight;
  final String? image;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.weight,
    this.image,
  });

  double get volume => sets * reps * weight;

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Exercise) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}