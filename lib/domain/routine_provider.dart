import 'package:fitness_app/data/routine_repository.dart';
import 'package:fitness_app/models/exercise.dart';
import 'package:flutter/foundation.dart';

class RoutineProvider extends ChangeNotifier {
  final RoutineRepository _repository;
  List<Exercise> _savedExercises = [];

  RoutineProvider(this._repository) {
    _init();
  }

  Future<void> _init() async {
    _savedExercises = await _repository.loadRoutine();
    notifyListeners();
  }

  List<Exercise> get savedExercises => List.unmodifiable(_savedExercises);

  int get exerciseCount => _savedExercises.length;

  int get totalSets =>
      _savedExercises.fold(0, (sum, exercise) => sum + exercise.sets);

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

  Future<void> addExercise(Exercise exercise) async {
    if (isSaved(exercise.id)) return;

    _savedExercises = [..._savedExercises, exercise];
    notifyListeners();
    await _repository.saveRoutine(_savedExercises);
  }

  Future<void> removeExercise(String id) async {
    _savedExercises = _savedExercises.where((e) => e.id != id).toList();
    notifyListeners();
    await _repository.saveRoutine(_savedExercises);
  }

  Future<void> clearAllExercises() async {
    _savedExercises = [];
    notifyListeners();
    await _repository.clearRoutine();
  }
}