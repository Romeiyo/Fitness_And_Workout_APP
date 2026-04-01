import 'dart:async';
import 'package:fitness_app/data/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'workout_phase.dart';

class WorkoutTrackingProvider extends ChangeNotifier {
  final LocationService _locationService;
  
  WorkoutPhase _workoutPhase = WorkoutPhase.idle;
  Position? _startPosition;
  Position? _endPosition;
  Position? _currentPosition;
  DateTime? _startTime;
  int _elapsedSeconds = 0;
  String? _errorMessage;
  bool _isLoadingLocation = false;
  
  Timer? _elapsedTimer;
  
  WorkoutTrackingProvider(this._locationService);
  
  WorkoutPhase get workoutPhase => _workoutPhase;
  Position? get startPosition => _startPosition;
  Position? get endPosition => _endPosition;
  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;
  bool get isLoadingLocation => _isLoadingLocation;
  
  String get formattedTime {
    int hours = _elapsedSeconds ~/ 3600;
    int minutes = (_elapsedSeconds % 3600) ~/ 60;
    int seconds = _elapsedSeconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  double get totalDistance {
    if (_startPosition == null || _endPosition == null) return 0.0;
    return _locationService.calculateDistance(
      _startPosition!.latitude,
      _startPosition!.longitude,
      _endPosition!.latitude,
      _endPosition!.longitude,
    );
  }
  
  String get formattedDistance {
    double distance = totalDistance;
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    }
    return '${(distance / 1000).toStringAsFixed(1)} km';
  }
  
  String get formattedPace {
    double distanceKm = totalDistance / 1000;
    if (distanceKm <= 0 || _elapsedSeconds <= 0) {
      return '--';
    }
    
    double minutesPerKm = (_elapsedSeconds / 60) / distanceKm;
    int minutes = minutesPerKm.floor();
    int seconds = ((minutesPerKm - minutes) * 60).round();
    
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} min/km';
  }
  
  bool get canFinish => _workoutPhase == WorkoutPhase.active;
  
  Future<void> startWorkout() async {
    _isLoadingLocation = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      Position position = await _locationService.getCurrentPosition();
      _startPosition = position;
      _currentPosition = position;
      _startTime = DateTime.now();
      _elapsedSeconds = 0;
      _workoutPhase = WorkoutPhase.active;
      
      _elapsedTimer?.cancel();
      _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_workoutPhase == WorkoutPhase.active && _startTime != null) {
          _elapsedSeconds = DateTime.now().difference(_startTime!).inSeconds;
          notifyListeners();
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
  
  Future<void> finishWorkout() async {
    _isLoadingLocation = true;
    notifyListeners();
    
    _elapsedTimer?.cancel();
    
    try {
      Position position = await _locationService.getCurrentPosition();
      _endPosition = position;
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _workoutPhase = WorkoutPhase.finished;
    _isLoadingLocation = false;
    notifyListeners();
  }
  
  void resetWorkout() {
    _elapsedTimer?.cancel();
    
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
    _elapsedTimer?.cancel();
    super.dispose();
  }
}