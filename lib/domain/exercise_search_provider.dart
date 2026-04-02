import 'package:fitness_app/data/api_repository.dart';
import 'package:fitness_app/models/api_exercise.dart';
import 'package:flutter/material.dart';

/// Provider for managing exercise search state
/// Handles API calls to fetch exercises and manages search results
class ExerciseSearchProvider extends ChangeNotifier {
  // Repository for API operations
  final ExerciseApiRepository _repository;
  
  // List of search results
  List<ApiExercise> _searchResults = [];
  
  // Loading state indicator
  bool _isLoading = false;
  
  // Error message if search fails
  String? _errorMessage;
  
  // Last search query (used for retry functionality)
  String _lastQuery = '';
  
  /// Constructor - injects repository dependency
  ExerciseSearchProvider(this._repository);
  
  // Getters
  List<ApiExercise> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get lastQuery => _lastQuery;
  bool get hasResults => _searchResults.isNotEmpty;
  bool get hasError => _errorMessage != null;
  
  /// Searches for exercises by muscle group
  /// @param muscle - Muscle group to search for
  Future<void> searchExercises(String muscle) async {
    // Trim and lowercase the query for consistency
    final trimmedQuery = muscle.trim().toLowerCase();
    
    // Don't search empty queries
    if (trimmedQuery.isEmpty) return;
    
    // Store query for retry functionality
    _lastQuery = trimmedQuery;
    
    // Set loading state
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      // Fetch results from API
      final results = await _repository.searchExercises(trimmedQuery);
      _searchResults = results;
    } catch (e) {
      // Store error message and clear results
      _errorMessage = e.toString();
      _searchResults = [];
    } finally {
      // Reset loading state
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Retries the last search
  /// Useful when network error occurs
  Future<void> retry() async {
    if (_lastQuery.isNotEmpty) {
      await searchExercises(_lastQuery);
    }
  }
  
  /// Clears all search state
  void clearResults() {
    _searchResults = [];
    _errorMessage = null;
    _lastQuery = '';
    _isLoading = false;
    notifyListeners();
  }
}