import 'package:fitness_app/data/auth_service.dart';
import 'package:flutter/material.dart';

/// Provider for managing authentication state
/// Extends ChangeNotifier to update UI when auth state changes
class AuthProvider extends ChangeNotifier {
  // Reference to AuthService for authentication operations
  final AuthService _authService;
  
  // Loading state - true when async operation is in progress
  bool _isLoading = false;
  
  // Error message if last operation failed
  String? _errorMessage;
  
  /// Constructor - injects AuthService dependency
  AuthProvider(this._authService);
  
  // Getters for accessing private state
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  String? get userEmail => _authService.currentUser?.email;
  String? get userId => _authService.currentUser?.uid;

  /// Returns user's display name (email username part or "User")
  String get displayName {
    if (userEmail == null) return 'User';
    // Extract part before '@' in email
    return userEmail!.split('@').first;
  }
  
  /// Clears error message
  void clearError() {
    _errorMessage = null;
    notifyListeners(); // Trigger UI update
  }
  
  /// Registers a new user
  /// @param email - User's email
  /// @param password - User's password
  /// @returns true if registration successful, false otherwise
  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Show loading indicator
    
    try {
      final user = await _authService.register(email, password);
      return user != null;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners(); // Hide loading indicator
    }
  }

  /// Logs in existing user
  /// @param email - User's email
  /// @param password - User's password
  /// @returns true if login successful, false otherwise
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final user = await _authService.login(email, password);
      return user != null;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Logs out current user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _authService.logout();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Sends password reset email
  /// @param email - User's email address
  /// @returns true if email sent successfully, false otherwise
  Future<bool> resetPassword(String email) async {
    // Validate email is provided
    if (email.trim().isEmpty) {
      _errorMessage = 'Please enter your email address first.';
      notifyListeners();
      return false;
    }
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}