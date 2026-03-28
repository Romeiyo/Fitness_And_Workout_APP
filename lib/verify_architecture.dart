import 'dart:io';

void main() async {
  print('=== Architecture Verification ===\n');
  
  bool allPassed = true;
  
  allPassed &= await checkLayer(
    'presentation',
    'shared_preferences',
    'presentation layer must not import shared_preferences',
  );
  
  allPassed &= await checkLayer(
    'data',
    'ChangeNotifier',
    'data layer must not import ChangeNotifier',
  );
  
  allPassed &= await checkLayer(
    'domain',
    'shared_preferences',
    'domain layer must not import shared_preferences',
  );
  
  print('\n=== Verification ${allPassed ? 'PASSED' : 'FAILED'} ===');
  exit(allPassed ? 0 : 1);
}

Future<bool> checkLayer(String folder, String forbiddenImport, String message) async {
  final directory = Directory('lib/$folder');
  if (!await directory.exists()) {
    print('$folder folder not found');
    return true;
  }
  
  final files = directory.listSync(recursive: true);
  bool passed = true;
  
  for (final file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = await file.readAsString();
      if (content.contains(forbiddenImport)) {
        print('FAIL: $message');
        print('Found in: ${file.path}');
        passed = false;
      }
    }
  }
  
  if (passed) {
    print('PASS: $message');
  }
  
  return passed;
}