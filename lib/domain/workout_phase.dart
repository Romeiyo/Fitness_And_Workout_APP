/// Enum representing the current state of a workout
/// Used by WorkoutTrackingProvider to manage workout lifecycle
enum WorkoutPhase {
  idle,      // No active workout - user can start a new workout
  active,    // Workout in progress - tracking location and time
  finished,  // Workout completed - showing summary
}