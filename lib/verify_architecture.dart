import 'dart:io';

/// Architecture verification script
/// Ensures proper layer separation in the app architecture
/// Prevents violations like UI layer accessing data layer directly
void main() async {
  print('=== Architecture Verification ===\n');
  
  bool allPassed = true;
  
  // Check that presentation layer doesn't import shared_preferences
  // Presentation layer should only depend on domain layer, not data layer
  allPassed &= await checkLayer(
    'presentation',
    'shared_preferences',
    'presentation layer must not import shared_preferences',
  );
  
  // Check that data layer doesn't use ChangeNotifier
  // Data layer should be pure data operations, no UI state management
  allPassed &= await checkLayer(
    'data',
    'ChangeNotifier',
    'data layer must not import ChangeNotifier',
  );
  
  // Check that domain layer doesn't use shared_preferences
  // Domain layer should be pure business logic, no storage implementation
  allPassed &= await checkLayer(
    'domain',
    'shared_preferences',
    'domain layer must not import shared_preferences',
  );
  
  print('\n=== Verification ${allPassed ? 'PASSED' : 'FAILED'} ===');
  exit(allPassed ? 0 : 1);
}

/// Checks if any file in the given folder contains a forbidden import
/// Returns true if verification passes, false if violation found
Future<bool> checkLayer(String folder, String forbiddenImport, String message) async {
  // Create a directory object for the specified folder
  final directory = Directory('lib/$folder');
  
  // If folder doesn't exist, verification passes (no files to check)
  if (!await directory.exists()) {
    print('$folder folder not found');
    return true;
  }
  
  // Get all files in directory recursively (including subdirectories)
  final files = directory.listSync(recursive: true);
  bool passed = true;
  
  // Iterate through each file
  for (final file in files) {
    // Check if it's a Dart file
    if (file is File && file.path.endsWith('.dart')) {
      // Read file contents
      final content = await file.readAsString();
      
      // Check if file contains the forbidden import
      if (content.contains(forbiddenImport)) {
        // Violation found - print error message and file path
        print('FAIL: $message');
        print('Found in: ${file.path}');
        passed = false;
      }
    }
  }
  
  // Print success message if no violations found
  if (passed) {
    print('PASS: $message');
  }
  
  return passed;
}