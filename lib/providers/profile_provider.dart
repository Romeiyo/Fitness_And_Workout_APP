import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  // Private variables with defaults
  String _name = 'Guest';
  int _age = 0;
  double _weightGoal = 0.0;
  String _weightUnit = 'kg';
  int _restTimer = 60;
  bool _notificationsEnabled = true;

  // Public getters
  String get name => _name;
  int get age => _age;
  double get weightGoal => _weightGoal;
  String get weightUnit => _weightUnit;
  int get restTimer => _restTimer;
  bool get notificationsEnabled => _notificationsEnabled;

  // Constructor - loads all data on initialization
  ProfileProvider() {
    _loadAll();
  }

  // Load all data from SharedPreferences with validation
  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();

    // Load name (no validation needed, just default if missing)
    _name = prefs.getString('profile_name') ?? 'Guest';

    // Load age with validation
    int? storedAge = prefs.getInt('profile_age');
    if (storedAge != null) {
      // Age must be between 1 and 120, otherwise set to 0
      _age = (storedAge >= 1 && storedAge <= 120) ? storedAge : 0;
    } else {
      _age = 0;
    }

    // Load weight goal with validation
    double? storedWeightGoal = prefs.getDouble('profile_weight_goal');
    if (storedWeightGoal != null) {
      // Weight goal must be positive, otherwise set to 0.0
      _weightGoal = storedWeightGoal > 0 ? storedWeightGoal : 0.0;
    } else {
      _weightGoal = 0.0;
    }

    // Load weight unit with validation
    String? storedWeightUnit = prefs.getString('pref_weight_unit');
    if (storedWeightUnit != null) {
      // Must be either 'kg' or 'lbs'
      _weightUnit = (storedWeightUnit == 'kg' || storedWeightUnit == 'lbs') 
          ? storedWeightUnit 
          : 'kg';
    } else {
      _weightUnit = 'kg';
    }

    // Load rest timer with validation and clamping
    int? storedRestTimer = prefs.getInt('pref_rest_timer');
    if (storedRestTimer != null) {
      // Clamp between 15 and 300 seconds
      _restTimer = storedRestTimer.clamp(15, 300);
    } else {
      _restTimer = 60;
    }

    // Load notifications preference
    _notificationsEnabled = prefs.getBool('pref_notifications') ?? true;

    notifyListeners();
  }

  // Save name method
  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _name = name.trim().isEmpty ? 'Guest' : name.trim();
    await prefs.setString('profile_name', _name);
    notifyListeners();
  }

  // Save age method with validation
  Future<void> saveAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    // Validate age before saving
    if (age >= 1 && age <= 120) {
      _age = age;
      await prefs.setInt('profile_age', age);
    } else {
      _age = 0;
      await prefs.setInt('profile_age', 0);
    }
    notifyListeners();
  }

  // Save weight goal method with validation
  Future<void> saveWeightGoal(double weightGoal) async {
    final prefs = await SharedPreferences.getInstance();
    if (weightGoal > 0) {
      _weightGoal = weightGoal;
      await prefs.setDouble('profile_weight_goal', weightGoal);
    } else {
      _weightGoal = 0.0;
      await prefs.setDouble('profile_weight_goal', 0.0);
    }
    notifyListeners();
  }

  // Save weight unit preference
  Future<void> saveWeightUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    if (unit == 'kg' || unit == 'lbs') {
      _weightUnit = unit;
      await prefs.setString('pref_weight_unit', unit);
      notifyListeners();
    }
  }

  // Save rest timer preference
  Future<void> saveRestTimer(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    // Clamp to valid range
    _restTimer = seconds.clamp(15, 300);
    await prefs.setInt('pref_rest_timer', _restTimer);
    notifyListeners();
  }

  // Save notifications preference
  Future<void> saveNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = enabled;
    await prefs.setBool('pref_notifications', enabled);
    notifyListeners();
  }

  // Reset only profile data (keeps preferences)
  Future<void> resetProfile() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Clear profile keys
    await prefs.remove('profile_name');
    await prefs.remove('profile_age');
    await prefs.remove('profile_weight_goal');
    
    // Reset provider variables to defaults
    _name = 'Guest';
    _age = 0;
    _weightGoal = 0.0;
    
    notifyListeners();
  }

  // Reset everything (both profile and preferences)
  Future<void> resetEverything() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Clear all keys
    await prefs.remove('profile_name');
    await prefs.remove('profile_age');
    await prefs.remove('profile_weight_goal');
    await prefs.remove('pref_weight_unit');
    await prefs.remove('pref_rest_timer');
    await prefs.remove('pref_notifications');
    
    // Reset all provider variables to defaults
    _name = 'Guest';
    _age = 0;
    _weightGoal = 0.0;
    _weightUnit = 'kg';
    _restTimer = 60;
    _notificationsEnabled = true;
    
    notifyListeners();
  }
}