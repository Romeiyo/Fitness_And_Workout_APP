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

  factory Exercise.fromMap(Map<String, dynamic> map, {String? id}) {
    return Exercise(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: map['name'] as String,
      muscleGroup: map['muscleGroup'] as String,
      sets: map['sets'] as int,
      reps: map['reps'] as int,
      weight: map['weight'] as double,
      image: map['image'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Exercise) return false;
    return id == other.id; 
  }

  @override
  int get hashCode => id.hashCode;
}