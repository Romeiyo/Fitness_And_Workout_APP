import 'package:fitness_app/data/profile_repository.dart';
import 'package:fitness_app/models/user_profile.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repository;
  UserProfile _profile;

  ProfileProvider(this._repository) : _profile = UserProfile.defaults() {
    _init();
  }

  Future<void> _init() async {
    _profile = await _repository.loadProfile();
    notifyListeners();
  }

  String get name => _profile.name;
  int get age => _profile.age;
  double get weightGoal => _profile.weightGoal;
  String get weightUnit => _profile.weightUnit;
  int get restTimer => _profile.restTimerSeconds;
  bool get notificationsEnabled => _profile.notificationsEnabled;
  bool get isMetric => _profile.weightUnit == 'kg';
  UserProfile get profile => _profile;

  Future<void> updateName(String name) async {
    _profile = _profile.copyWith(name: name);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> updateAge(int age) async {
    _profile = _profile.copyWith(age: age);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> updateWeightGoal(double weightGoal) async {
    _profile = _profile.copyWith(weightGoal: weightGoal);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> updateWeightUnit(String unit) async {
    if (unit == 'kg' || unit == 'lbs') {
      _profile = _profile.copyWith(weightUnit: unit);
      notifyListeners();
      await _repository.saveProfile(_profile);
    }
  }

  Future<void> updateRestTimer(int seconds) async {
    final clampedSeconds = seconds.clamp(15, 300);
    _profile = _profile.copyWith(restTimerSeconds: clampedSeconds);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  void previewRestTimer(int seconds) {
    final clampedSeconds = seconds.clamp(15, 300);
    _profile = _profile.copyWith(restTimerSeconds: clampedSeconds);
    notifyListeners();
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    _profile = _profile.copyWith(notificationsEnabled: enabled);
    notifyListeners();
    await _repository.saveProfile(_profile);
  }

  Future<void> resetProfile() async {
    _profile = UserProfile.defaults();
    notifyListeners();
    await _repository.clearProfile();
  }

  Future<void> resetEverything() async {
    _profile = UserProfile.defaults();
    notifyListeners();
    await _repository.clearProfile();
  }
}