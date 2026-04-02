import 'dart:convert';
import 'package:fitness_app/models/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for storing and retrieving user's workout routines
/// Saves list of exercises to local storage
class RoutineRepository {
  // Key used to store routine data in SharedPreferences
  static const String _key = 'user_routine';

  /// Saves workout routine to persistent storage
  /// @param routine - List of Exercise objects to save
  Future<void> saveRoutine(List<Exercise> routine) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert each Exercise to a JSON map, then convert list to JSON string
    final List<Map<String, dynamic>> jsonList =
        routine.map((exercise) => exercise.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    
    await prefs.setString(_key, jsonString);
  }

  /// Loads workout routine from persistent storage
  /// @returns List of Exercise objects, or empty list if none exists
  Future<List<Exercise>> loadRoutine() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // Return empty list if no routine is saved
    if (jsonString == null) {
      return [];
    }

    try {
      // Parse JSON string back to list of maps
      final List<dynamic> jsonList = jsonDecode(jsonString);
      // Convert each map to Exercise object
      return jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If parsing fails, return empty list and log error
      print('Error loading routine: $e');
      return [];
    }
  }

  /// Removes routine from persistent storage
  /// Used when user clears all saved exercises
  Future<void> clearRoutine() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}