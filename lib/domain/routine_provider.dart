import 'package:flutter/material.dart';
import '../models/exercise.dart';

class RoutineProvider extends ChangeNotifier {
  final List<Exercise> _savedExercises = [];

  List<Exercise> get savedExercises => List.unmodifiable(_savedExercises);

  int get exerciseCount => _savedExercises.length;

  int get totalSets => _savedExercises.fold(0, (sum, exercise) => sum + exercise.sets);

  double get totalVolume =>
      _savedExercises.fold(0.0, (sum, exercise) => sum + exercise.volume);

  bool isSaved(String id) {
    return _savedExercises.any((exercise) => exercise.id == id);
  }

  Map<String, int> get muscleGroupBreakdown {
    final Map<String, int> breakdown = {};
    for (final exercise in _savedExercises) {
      breakdown[exercise.muscleGroup] =
          (breakdown[exercise.muscleGroup] ?? 0) + 1;
    }
    return breakdown;
  }

  void addExercise(Exercise exercise) {
    if (isSaved(exercise.id)) {
      return;
    }
    _savedExercises.add(exercise);
    notifyListeners();
  }

  void removeExercise(String id) {
    _savedExercises.removeWhere((exercise) => exercise.id == id);
    notifyListeners();
  }

  void clearAllExercises() {
    _savedExercises.clear();
    notifyListeners();
  }
}