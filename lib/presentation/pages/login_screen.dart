import 'package:fitness_app/domain/auth_provider.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Login screen for user authentication
/// Provides both login and registration functionality with form validation
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers for form inputs
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // UI state variables
  bool _isLoginMode = true;           // Toggle between login and register modes
  bool _obscurePassword = true;        // Hide password text for security
  bool _obscureConfirmPassword = true;  // Hide confirm password text
  
  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  /// Clears error messages when email field changes
  void _handleEmailChanged(String _) {
    context.read<AuthProvider>().clearError();
  }
  
  /// Clears error messages when password field changes
  void _handlePasswordChanged(String _) {
    context.read<AuthProvider>().clearError();
  }
  
  /// Handles form submission for login or registration
  Future<void> _submit() async {
    // Validate all form fields before proceeding
    if (!_formKey.currentState!.validate()) return;
    
    final authProvider = context.read<AuthProvider>();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    
    // Perform login or registration based on current mode
    bool success;
    if (_isLoginMode) {
      success = await authProvider.login(email, password);
    } else {
      success = await authProvider.register(email, password);
    }
    
    // If successful, clear form and navigate to main app
    if (success && mounted) {
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      
      // Navigate to main screen and remove login screen from history
      context.pushRouteAndRemoveUntil(AppRoute.mainNavigationScreen);
    }
  }
  
  /// Handles password reset request
  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    
    // Validate email is entered before sending reset link
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.resetPassword(email);
    
    // Show success message if reset email was sent
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent to $email'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  /// Toggles between login and registration modes
  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
    // Clear any previous error messages when switching modes
    context.read<AuthProvider>().clearError();
  }
  
  /// Validates email format
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // Basic email validation - must contain @ and .
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  
  /// Validates password strength
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // In registration mode, password must be at least 6 characters
    if (!_isLoginMode && value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  /// Validates password confirmation (registration mode only)
  String? _validateConfirmPassword(String? value) {
    if (_isLoginMode) return null;  // Only validate in registration mode
    
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              
              // App logo/icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.lightGreenAccent, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              
              // Title based on current mode
              Text(
                _isLoginMode ? 'Welcome Back!' : 'Create Account',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Subtitle based on current mode
              Text(
                _isLoginMode 
                  ? 'Sign in to continue your fitness journey' 
                  : 'Start your fitness journey today',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Display error message if any
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  if (!authProvider.hasError) return const SizedBox.shrink();
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authProvider.errorMessage!,
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              // Login/Registration form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email field
                    TextFormField(
                      controller: _emailController,
                      onChanged: _handleEmailChanged,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'your@email.com',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                    const SizedBox(height: 16),
                    
                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      onChanged: _handlePasswordChanged,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword 
                              ? Icons.visibility_off 
                              : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    
                    // Confirm password field (registration mode only)
                    if (!_isLoginMode) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: _validateConfirmPassword,
                      ),
                    ],
                    
                    const SizedBox(height: 24),
                    
                    // Submit button
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return ElevatedButton(
                          onPressed: authProvider.isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.lightGreenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: authProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _isLoginMode ? 'Sign In' : 'Create Account',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Forgot password link (login mode only)
                    if (_isLoginMode)
                      TextButton(
                        onPressed: _handleForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    
                    const SizedBox(height: 24),
                    
                    // Toggle between login and registration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLoginMode 
                            ? "Don't have an account? " 
                            : "Already have an account? ",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        TextButton(
                          onPressed: _toggleMode,
                          child: Text(
                            _isLoginMode ? 'Register' : 'Sign In',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}