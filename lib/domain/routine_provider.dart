import 'package:fitness_app/data/routine_repository.dart';
import 'package:fitness_app/models/exercise.dart';
import 'package:flutter/foundation.dart';

/// Provider for managing user's saved workout routine
/// Handles adding, removing, and analyzing exercises
class RoutineProvider extends ChangeNotifier {
  // Repository for persistent storage
  final RoutineRepository _repository;
  
  // List of saved exercises
  List<Exercise> _savedExercises = [];

  /// Constructor - loads saved exercises on creation
  RoutineProvider(this._repository) {
    _init();
  }

  /// Initializes provider by loading saved exercises
  Future<void> _init() async {
    _savedExercises = await _repository.loadRoutine();
    notifyListeners();
  }

  // Getters for routine data
  List<Exercise> get savedExercises => List.unmodifiable(_savedExercises);
  int get exerciseCount => _savedExercises.length;

  /// Calculates total number of sets across all exercises
  int get totalSets =>
      _savedExercises.fold(0, (sum, exercise) => sum + exercise.sets);

  /// Calculates total volume (sets × reps × weight) across all exercises
  double get totalVolume =>
      _savedExercises.fold(0.0, (sum, exercise) => sum + exercise.volume);

  /// Checks if an exercise is already saved
  /// @param id - Exercise ID to check
  bool isSaved(String id) {
    return _savedExercises.any((exercise) => exercise.id == id);
  }

  /// Provides breakdown of exercises by muscle group
  /// Returns map of muscle group name to count
  Map<String, int> get muscleGroupBreakdown {
    final Map<String, int> breakdown = {};
    for (final exercise in _savedExercises) {
      // Increment count for this muscle group
      breakdown[exercise.muscleGroup] =
          (breakdown[exercise.muscleGroup] ?? 0) + 1;
    }
    return breakdown;
  }

  /// Adds an exercise to the routine
  /// @param exercise - Exercise to add
  Future<void> addExercise(Exercise exercise) async {
    // Prevent duplicate exercises
    if (isSaved(exercise.id)) return;

    // Create new list with added exercise (immutable pattern)
    _savedExercises = [..._savedExercises, exercise];
    notifyListeners(); // Update UI
    await _repository.saveRoutine(_savedExercises); // Persist changes
  }

  /// Removes an exercise from the routine
  /// @param id - ID of exercise to remove
  Future<void> removeExercise(String id) async {
    // Filter out exercise with matching ID
    _savedExercises = _savedExercises.where((e) => e.id != id).toList();
    notifyListeners();
    await _repository.saveRoutine(_savedExercises);
  }

  /// Removes all exercises from the routine
  Future<void> clearAllExercises() async {
    _savedExercises = [];
    notifyListeners();
    await _repository.clearRoutine();
  }
}