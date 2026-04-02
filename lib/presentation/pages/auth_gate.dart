import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/data/auth_service.dart';
import 'package:fitness_app/presentation/pages/login_screen.dart';
import 'package:fitness_app/presentation/pages/main_navigation_screen.dart';
import 'package:flutter/material.dart';

/// AuthGate is the entry point screen that determines which screen to show
/// based on the user's authentication state.
/// 
/// This widget listens to Firebase Auth state changes and conditionally
/// shows either the login screen (if not authenticated) or the main app
/// (if authenticated).
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // AuthService instance for listening to auth state changes
  late final AuthService _authService;
  
  @override
  void initState() {
    super.initState();
    // Initialize AuthService when widget is created
    _authService = AuthService();
  }
  
  @override
  Widget build(BuildContext context) {
    // StreamBuilder listens to auth state changes in real-time
    // When user logs in/out, this widget rebuilds automatically
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        // Show loading indicator while checking authentication state
        // This prevents showing the wrong screen during the initial check
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Checking authentication...'),
                ],
              ),
            ),
          );
        }
        
        // User is authenticated - show the main app
        if (snapshot.hasData) {
          return const MainNavigationScreen();
        }
        
        // No user is authenticated - show login screen
        return const LoginScreen();
      },
    );
  }
}