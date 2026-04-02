/// Model representing user profile data
/// Contains personal information and app preferences
class UserProfile {
  // Personal information
  final String name;              // User's display name
  final int age;                  // User's age (0 if not set)
  final double weightGoal;        // Target weight (0 if not set)
  
  // Preferences
  final String weightUnit;        // 'kg' or 'lbs'
  final int restTimerSeconds;     // Rest timer duration (15-300 seconds)
  final bool notificationsEnabled; // Whether to show notifications

  /// Constructor with all fields required
  const UserProfile({
    required this.name,
    required this.age,
    required this.weightGoal,
    required this.weightUnit,
    required this.restTimerSeconds,
    required this.notificationsEnabled,
  });

  /// Creates a default profile for new users
  /// Uses sensible defaults: Guest user, metric units, 60-second rest timer
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

  /// Converts UserProfile to JSON for storage
  /// @returns Map containing all profile data
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

  /// Factory constructor to create UserProfile from JSON
  /// Includes validation to ensure data is within valid ranges
  /// @param json - Map containing stored profile data
  /// @returns UserProfile instance with validated values
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Validate age (0-120, with 0 meaning not set)
    int age = json['age'] as int? ?? 0;
    if (age < 0 || age > 120) age = 0;

    // Validate weight goal (non-negative)
    double weightGoal = json['weightGoal'] as double? ?? 0.0;
    if (weightGoal < 0) weightGoal = 0.0;

    // Validate weight unit (only 'kg' or 'lbs' allowed)
    String weightUnit = json['weightUnit'] as String? ?? 'kg';
    if (weightUnit != 'kg' && weightUnit != 'lbs') weightUnit = 'kg';

    // Validate rest timer (15-300 seconds)
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

  /// Creates a copy with optional updated fields
  /// Enables immutable updates of specific fields
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

  /// String representation for debugging
  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, weightGoal: $weightGoal, '
        'weightUnit: $weightUnit, restTimerSeconds: $restTimerSeconds, '
        'notificationsEnabled: $notificationsEnabled)';
  }
}