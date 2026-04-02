import 'package:firebase_auth/firebase_auth.dart';

/// Service for handling Firebase Authentication operations
/// Provides methods for user registration, login, logout, and password reset
class AuthService {
  // FirebaseAuth instance for authentication operations
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  /// Returns the currently logged-in user, or null if not authenticated
  User? get currentUser => _auth.currentUser;
  
  /// Returns true if user is currently signed in
  bool get isSignedIn => _auth.currentUser != null;
  
  /// Stream that emits authentication state changes
  /// Used for reactive UI updates when user logs in/out
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  /// Registers a new user with email and password
  /// @param email - User's email address (will be trimmed)
  /// @param password - User's password (min 6 chars)
  /// @returns User object on success, null on failure
  Future<User?> register(String email, String password) async {
    try {
      // Create new user account with trimmed email
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Convert Firebase error codes to user-friendly messages
      throw Exception(_mapAuthError(e.code));
    } catch (e) {
      // Generic authentication failure
      throw Exception('Authentication failed. Please try again.');
    }
  }
  
  /// Logs in existing user with email and password
  /// @param email - User's email address (will be trimmed)
  /// @param password - User's password
  /// @returns User object on success, null on failure
  Future<User?> login(String email, String password) async {
    try {
      // Sign in with trimmed email
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e.code));
    } catch (e) {
      throw Exception('Authentication failed. Please try again.');
    }
  }
  
  /// Logs out the current user
  Future<void> logout() async {
    await _auth.signOut();
  }
  
  /// Sends password reset email to user
  /// @param email - User's email address to send reset link
  Future<void> resetPassword(String email) async {
    try {
      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e.code));
    } catch (e) {
      throw Exception('Failed to send reset email. Please try again.');
    }
  }
  
  /// Checks if current user session is still valid
  /// Tries to refresh user data from Firebase
  /// @returns true if session valid, false if invalid (logs out)
  Future<bool> checkSessionValidity() async {
    try {
      // Attempt to reload user data from Firebase
      await _auth.currentUser?.reload();
      return true;
    } catch (e) {
      // If reload fails, session is invalid - log out user
      await logout();
      return false;
    }
  }
  
  /// Maps Firebase error codes to user-friendly messages
  /// @param code - Firebase authentication error code
  /// @returns User-friendly error message
  String _mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'Invalid email or password.';
      case 'wrong-password':
        return 'Invalid email or password.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'No internet connection. Check your network.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}