import 'dart:convert';
import 'package:fitness_app/models/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RoutineRepository {
  static const String _key = 'user_routine';

  Future<void> saveRoutine(List<Exercise> routine) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        routine.map((exercise) => exercise.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_key, jsonString);
  }

  Future<List<Exercise>> loadRoutine() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading routine: $e');
      return [];
    }
  }

  Future<void> clearRoutine() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}