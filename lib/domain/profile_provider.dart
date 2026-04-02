import 'package:fitness_app/data/profile_repository.dart';
import 'package:fitness_app/models/user_profile.dart';
import 'package:flutter/foundation.dart';

/// Provider for managing user profile data
/// Handles loading, updating, and saving profile information
class ProfileProvider extends ChangeNotifier {
  // Repository for persistent storage
  final ProfileRepository _repository;
  
  // Current user profile
  UserProfile _profile;

  /// Constructor - loads profile on creation
  ProfileProvider(this._repository) : _profile = UserProfile.defaults() {
    _init();
  }

  /// Initializes provider by loading saved profile
  Future<void> _init() async {
    _profile = await _repository.loadProfile();
    notifyListeners();
  }

  // Getters for profile fields
  String get name => _profile.name;
  int get age => _profile.age;
  double get weightGoal => _profile.weightGoal;
  String get weightUnit => _profile.weightUnit;
  int get restTimer => _profile.restTimerSeconds;
  bool get notificationsEnabled => _profile.notificationsEnabled;
  bool get isMetric => _profile.weightUnit == 'kg';
  UserProfile get profile => _profile;

  /// Updates user's name
  /// @param name - New name
  Future<void> updateName(String name) async {
    // Create new profile with updated name
    _profile = _profile.copyWith(name: name);
    notifyListeners(); // Update UI
    await _repository.saveProfile(_profile); // Persist changes
  }

  /// Updates user's age
  /// @param age - New age
  Future<void> updateAge(int age) async {
    _profile = _profile.copyWith(age: age);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  /// Updates weight goal
  /// @param weightGoal - New weight goal value
  Future<void> updateWeightGoal(double weightGoal) async {
    _profile = _profile.copyWith(weightGoal: weightGoal);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  /// Updates weight unit (kg or lbs)
  /// @param unit - New unit ('kg' or 'lbs')
  Future<void> updateWeightUnit(String unit) async {
    if (unit == 'kg' || unit == 'lbs') {
      _profile = _profile.copyWith(weightUnit: unit);
      notifyListeners();
      await _repository.saveProfile(_profile);
    }
  }

  /// Updates rest timer duration
  /// @param seconds - New duration in seconds (clamped to 15-300)
  Future<void> updateRestTimer(int seconds) async {
    // Ensure value stays within valid range
    final clampedSeconds = seconds.clamp(15, 300);
    _profile = _profile.copyWith(restTimerSeconds: clampedSeconds);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  /// Previews rest timer change without saving
  /// Used for slider dragging
  /// @param seconds - Preview duration
  void previewRestTimer(int seconds) {
    final clampedSeconds = seconds.clamp(15, 300);
    _profile = _profile.copyWith(restTimerSeconds: clampedSeconds);
    notifyListeners(); // Update UI but don't save yet
  }

  /// Updates notification preference
  /// @param enabled - Whether notifications should be enabled
  Future<void> updateNotificationsEnabled(bool enabled) async {
    _profile = _profile.copyWith(notificationsEnabled: enabled);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  /// Resets profile data only (name, age, weight goal)
  /// Preserves preferences (unit, timer, notifications)
  Future<void> resetProfile() async {
    // Create new profile with default values but keep preferences
    final defaultProfile = UserProfile.defaults();
    _profile = _profile.copyWith(
      name: defaultProfile.name,
      age: defaultProfile.age,
      weightGoal: defaultProfile.weightGoal,
    );
    notifyListeners();
    await _repository.clearProfile(); // Remove from storage
    await _repository.saveProfile(_profile); // Save reset version
  }

  /// Resets everything to default values
  /// Clears all user data and preferences
  Future<void> resetEverything() async {
    _profile = UserProfile.defaults();
    notifyListeners();
    await _repository.clearProfile();
  }
}