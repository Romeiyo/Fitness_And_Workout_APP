import 'package:fitness_app/data/api_repository.dart';
import 'package:fitness_app/models/api_exercise.dart';
import 'package:flutter/material.dart';

class ExerciseSearchProvider extends ChangeNotifier {
  final ExerciseApiRepository _repository;
  
  List<ApiExercise> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _lastQuery = '';
  
  ExerciseSearchProvider(this._repository);
  
  List<ApiExercise> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get lastQuery => _lastQuery;
  bool get hasResults => _searchResults.isNotEmpty;
  bool get hasError => _errorMessage != null;
  
  Future<void> searchExercises(String muscle) async {
    final trimmedQuery = muscle.trim().toLowerCase();
    
    if (trimmedQuery.isEmpty) return;
    
    _lastQuery = trimmedQuery;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final results = await _repository.searchExercises(trimmedQuery);
      _searchResults = results;
    } catch (e) {
      _errorMessage = e.toString();
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> retry() async {
    if (_lastQuery.isNotEmpty) {
      await searchExercises(_lastQuery);
    }
  }
  
  void clearResults() {
    _searchResults = [];
    _errorMessage = null;
    _lastQuery = '';
    _isLoading = false;
    notifyListeners();
  }
}