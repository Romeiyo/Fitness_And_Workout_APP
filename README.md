# Fitness & Workout Tracker

A comprehensive mobile fitness application built with Flutter that helps users discover exercises, track workouts, manage custom routines, and monitor their fitness progress.

## Features

### Exercise Library
- **9 Workout Categories**: Browse exercises across different workout types:
  - Cardio Exercises
  - Strength Workout
  - Flexibility Exercises
  - Aerobic Exercises
  - Balance Exercises
  - Mobility Training
  - Stretching Exercises
  - Warm-Up Exercises
  - Yoga Exercises

### Exercise Management
- **Custom Exercises**: Create and save personalized exercises with custom sets, reps, and weights
- **Favorites System**: Save exercises to your personal collection with a simple heart toggle
- **Exercise Details**: View detailed information including total volume calculation and muscle group targeting
- **Muscle Group Targeting**: Exercises categorized by specific muscle groups (Chest, Back, Legs, Arms, Shoulders, Core)

### User Profile & Settings
- **Personal Profile**: Save your name, age, and weight goals
- **Weight Units**: Toggle between kilograms (kg) and pounds (lbs)
- **Rest Timer**: Configurable timer duration (15-300 seconds) with live preview
- **Notifications**: Enable/disable workout reminders and tips
- **Data Management**: Reset profile data or clear all app data

### BMI Calculator
- **Instant BMI Calculation**: Enter height (cm) and weight (kg) for immediate results
- **Health Categories**: BMI results classified as Underweight, Normal, Overweight, or Obese
- **Personalized Advice**: Get health recommendations based on your BMI category
- **Clear Functionality**: Quick reset option for calculator fields

### Architecture & State Management
- **Clean Architecture**: Separation of concerns with presentation, domain, and data layers
- **Provider Pattern**: Reactive state management using Provider and ChangeNotifier
- **Repository Pattern**: Data persistence using SharedPreferences
- **Type-safe Navigation**: Custom AppRouter with generic argument support

### Responsive Design
- **Adaptive Grid Layouts**: Automatically adjusts column count based on screen size (mobile, tablet, desktop)
- **Material Design 3**: Modern UI with customizable themes and color schemes

## Getting Started

### Prerequisites

- Flutter SDK (version ^3.11.1 or higher)
- Dart SDK (version ^3.11.1 or higher)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Fitness_And_Workout_APP.git
```

2. Navigate to the project directory:
```bash
cd Fitness_And_Workout_APP
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```text
lib/
|-- models/          # Data models (Exercise, UserProfile)
|-- domain/          # Business logic (ProfileProvider, RoutineProvider)
|-- data/            # Data access (ProfileRepository, RoutineRepository)
|-- presentation/    # UI components
|   |-- pages/       # Screen widgets
|   |-- widgets/     # Reusable UI components
|-- routes/          # Navigation (AppRouter)
```

### Built With
- Flutter - UI framework
- Material Design 3 - Design system
- Provider - State management
- SharedPreferences - Local data persistence

### Architecture Verification
The project includes an automated architecture verification script that ensures proper layer separation:

- Presentation layer does not import SharedPreferences
- Data layer does not import ChangeNotifier
- Domain layer does not import SharedPreferences

Run verification with:
```bash
dart verify_architecture.dart
```

### Future Enhancements
- Add exercise videos/gifs with step-by-step instructions
- Implement workout progress tracking and history
- Add social sharing features for achievements
- Create workout plan generator based on user goals
- Add dark mode support
- Implement push notifications for rest timer
- Add cloud sync for cross-device data persistence
- Create workout analytics and statistics dashboard

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Author
Romio
Created as part of professional software development training at BitCube.