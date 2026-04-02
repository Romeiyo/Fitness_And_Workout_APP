# Fitness App Development Commands Reference

## Complete Command History for Flutter Fitness App Development

### 1. Initial Flutter Setup & Project Creation

```bash
# Check Flutter installation and version
flutter --version

# Create new Flutter project
flutter create fitness_app

# Navigate into project directory
cd fitness_app

# List available devices (emulators and physical devices)
flutter devices

# Run the app on available device
flutter run

# Run with specific device
flutter run -d <device_id>

# One Command
flutter create --org com.example --project-name travel_app --platforms android,ios,web travel_app

# Run in release mode (optimized for performance)
flutter run --release

# Run in profile mode (for performance profiling)
flutter run --profile

# Add dependencies to pubspec.yaml manually or via commands

# Core dependencies
flutter pub add provider              # State management
flutter pub add dio                    # HTTP client for API calls
flutter pub add shared_preferences     # Local storage
flutter pub add intl                   # Internationalization

# Firebase dependencies
flutter pub add firebase_core          # Firebase core functionality
flutter pub add firebase_auth          # Firebase authentication

# Location & Notifications
flutter pub add geolocator             # GPS location services
flutter pub add flutter_local_notifications  # Local notifications

# Install all dependencies
flutter pub get

# Check for outdated packages
flutter pub outdated

# Upgrade specific package
flutter pub upgrade provider

# Upgrade all packages
flutter pub upgrade

# Install FlutterFire CLI globally
dart pub global activate flutterfire_cli

# Configure Firebase for your project
# This will guide you through connecting to Firebase
flutterfire configure

# The above command generates firebase_options.dart
# It will ask you to:
# - Select your Firebase project
# - Choose platforms (Android, iOS, Web)
# - Select configuration options

# If you need to reconfigure Firebase
flutterfire configure --project=workout-app-bitcube

# Generate Firebase options for specific platforms
flutterfire configure --platforms=android,ios

# After configuration, verify Firebase is working
# Run the app to test Firebase connection
flutter run