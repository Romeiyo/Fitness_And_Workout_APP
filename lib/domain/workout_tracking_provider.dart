import 'dart:async';
import 'package:fitness_app/data/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'workout_phase.dart';

/// Provider for tracking outdoor workouts
/// Manages GPS location, timing, and workout state
class WorkoutTrackingProvider extends ChangeNotifier {
  // Service for location operations
  final LocationService _locationService;
  
  // Current phase of the workout
  WorkoutPhase _workoutPhase = WorkoutPhase.idle;
  
  // Position data
  Position? _startPosition;      // Starting point
  Position? _endPosition;        // Ending point
  Position? _currentPosition;    // Current position during workout
  
  // Timing data
  DateTime? _startTime;          // Workout start timestamp
  int _elapsedSeconds = 0;       // Total elapsed time in seconds
  
  // Error and loading states
  String? _errorMessage;
  bool _isLoadingLocation = false;
  
  // Timer for updating elapsed time every second
  Timer? _elapsedTimer;
  
  /// Constructor - injects location service dependency
  WorkoutTrackingProvider(this._locationService);
  
  // Getters
  WorkoutPhase get workoutPhase => _workoutPhase;
  Position? get startPosition => _startPosition;
  Position? get endPosition => _endPosition;
  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;
  bool get isLoadingLocation => _isLoadingLocation;
  
  /// Formats elapsed time as HH:MM:SS or MM:SS
  String get formattedTime {
    int hours = _elapsedSeconds ~/ 3600;      // Integer division for hours
    int minutes = (_elapsedSeconds % 3600) ~/ 60; // Remaining minutes
    int seconds = _elapsedSeconds % 60;       // Remaining seconds
    
    // Show hours only if more than 0
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Calculates total distance of the workout
  double get totalDistance {
    if (_startPosition == null || _endPosition == null) return 0.0;
    return _locationService.calculateDistance(
      _startPosition!.latitude,
      _startPosition!.longitude,
      _endPosition!.latitude,
      _endPosition!.longitude,
    );
  }
  
  /// Formats distance with appropriate units (m or km)
  String get formattedDistance {
    double distance = totalDistance;
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';  // Show in meters
    }
    return '${(distance / 1000).toStringAsFixed(1)} km'; // Show in kilometers
  }
  
  /// Calculates average pace (minutes per kilometer)
  String get formattedPace {
    double distanceKm = totalDistance / 1000;
    if (distanceKm <= 0 || _elapsedSeconds <= 0) {
      return '--';  // Invalid data
    }
    
    // Calculate minutes per kilometer
    double minutesPerKm = (_elapsedSeconds / 60) / distanceKm;
    int minutes = minutesPerKm.floor();
    int seconds = ((minutesPerKm - minutes) * 60).round();
    
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} min/km';
  }
  
  /// Returns whether workout can be finished
  bool get canFinish => _workoutPhase == WorkoutPhase.active;
  
  /// Starts a new workout
  /// Gets current location and begins timing
  Future<void> startWorkout() async {
    _isLoadingLocation = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      // Get starting position
      Position position = await _locationService.getCurrentPosition();
      _startPosition = position;
      _currentPosition = position;
      _startTime = DateTime.now();
      _elapsedSeconds = 0;
      _workoutPhase = WorkoutPhase.active;
      
      // Start timer that updates elapsed time every second
      _elapsedTimer?.cancel(); // Cancel existing timer if any
      _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_workoutPhase == WorkoutPhase.active && _startTime != null) {
          _elapsedSeconds = DateTime.now().difference(_startTime!).inSeconds;
          notifyListeners(); // Update UI every second
        }
      });
      
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _workoutPhase = WorkoutPhase.idle;
      notifyListeners();
    } finally {
      _isLoadingLocation = false;
      notifyListeners();
    }
  }
  
  /// Updates current location during active workout
  Future<void> updateLocation() async {
    if (_workoutPhase != WorkoutPhase.active) return;
    
    try {
      Position position = await _locationService.getCurrentPosition();
      _currentPosition = position;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
  
  /// Finishes the current workout
  /// Records ending position and stops timer
  Future<void> finishWorkout() async {
    _isLoadingLocation = true;
    notifyListeners();
    
    // Stop the elapsed time timer
    _elapsedTimer?.cancel();
    
    try {
      // Get final position
      Position position = await _locationService.getCurrentPosition();
      _endPosition = position;
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _workoutPhase = WorkoutPhase.finished;
    _isLoadingLocation = false;
    notifyListeners();
  }
  
  /// Resets workout state for a new workout
  void resetWorkout() {
    _elapsedTimer?.cancel(); // Stop timer
    
    // Reset all state variables
    _workoutPhase = WorkoutPhase.idle;
    _startPosition = null;
    _endPosition = null;
    _currentPosition = null;
    _startTime = null;
    _elapsedSeconds = 0;
    _errorMessage = null;
    _isLoadingLocation = false;
    
    notifyListeners();
  }
  
  @override
  void dispose() {
    // Clean up timer when provider is destroyed
    _elapsedTimer?.cancel();
    super.dispose();
  }
}