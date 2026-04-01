import 'package:fitness_app/data/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  
  bool _isLoading = false;
  String? _errorMessage;
  
  AuthProvider(this._authService);
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  String? get userEmail => _authService.currentUser?.email;
  String? get userId => _authService.currentUser?.uid;
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final user = await _authService.register(email, password);
      return user != null;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}