class UserProfile {
  final String name;
  final int age;
  final double weightGoal;
  final String weightUnit;
  final int restTimerSeconds;
  final bool notificationsEnabled;

  const UserProfile({
    required this.name,
    required this.age,
    required this.weightGoal,
    required this.weightUnit,
    required this.restTimerSeconds,
    required this.notificationsEnabled,
  });

  factory UserProfile.defaults() {
    return const UserProfile(
      name: 'Guest',
      age: 0,
      weightGoal: 0.0,
      weightUnit: 'kg',
      restTimerSeconds: 60,
      notificationsEnabled: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'weightGoal': weightGoal,
      'weightUnit': weightUnit,
      'restTimerSeconds': restTimerSeconds,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    int age = json['age'] as int? ?? 0;
    if (age < 0 || age > 120) age = 0;

    double weightGoal = json['weightGoal'] as double? ?? 0.0;
    if (weightGoal < 0) weightGoal = 0.0;

    String weightUnit = json['weightUnit'] as String? ?? 'kg';
    if (weightUnit != 'kg' && weightUnit != 'lbs') weightUnit = 'kg';

    int restTimer = json['restTimerSeconds'] as int? ?? 60;
    if (restTimer < 15) restTimer = 15;
    if (restTimer > 300) restTimer = 300;

    return UserProfile(
      name: json['name'] as String? ?? 'Guest',
      age: age,
      weightGoal: weightGoal,
      weightUnit: weightUnit,
      restTimerSeconds: restTimer,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );
  }

  UserProfile copyWith({
    String? name,
    int? age,
    double? weightGoal,
    String? weightUnit,
    int? restTimerSeconds,
    bool? notificationsEnabled,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      weightGoal: weightGoal ?? this.weightGoal,
      weightUnit: weightUnit ?? this.weightUnit,
      restTimerSeconds: restTimerSeconds ?? this.restTimerSeconds,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, weightGoal: $weightGoal, '
        'weightUnit: $weightUnit, restTimerSeconds: $restTimerSeconds, '
        'notificationsEnabled: $notificationsEnabled)';
  }
}