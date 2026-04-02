import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service for handling local notifications
/// Shows workout completion alerts and reminders
class NotificationService {
  // FlutterLocalNotificationsPlugin for cross-platform notifications
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  
  // Flag to prevent multiple initializations
  bool _isInitialized = false;
  
  /// Initializes the notification service
  /// Sets up notification channels for Android and permissions for iOS
  Future<void> init() async {
    // Prevent re-initialization
    if (_isInitialized) return;
    
    // Android configuration - uses app icon for notification
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // iOS configuration - requests permissions for alerts, badges, sounds
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,  // Show notification alerts
      requestBadgePermission: true,  // Show badge on app icon
      requestSoundPermission: true,  // Play sound for notifications
    );
    
    // Combined settings for both platforms
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    // Initialize the plugin with settings
    await _plugin.initialize(settings: settings);
    _isInitialized = true;
  }
  
  /// Shows a notification when user completes a workout
  /// @param workoutName - Name of the completed workout
  /// @param stats - Workout statistics (distance, time, etc.)
  Future<void> showWorkoutCompleteAlert({
    required String workoutName,
    required String stats,
  }) async {
    // Ensure service is initialized
    if (!_isInitialized) await init();
    
    // Android notification channel for workout completions
    // Channel ID must be unique and consistent across notifications
    const androidDetails = AndroidNotificationDetails(
      'workout_complete',           // Channel ID
      'Workout Completion',          // Channel name
      channelDescription: 'Notifications when you complete a workout',
      importance: Importance.max,    // High importance - makes sound and pops up
      priority: Priority.high,       // High priority for immediate delivery
      playSound: true,               // Play sound when notification arrives
      enableVibration: true,         // Vibrate device
    );
    
    // iOS configuration (uses default settings)
    const iosDetails = DarwinNotificationDetails();
    
    // Combined notification details
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    // Show notification with unique ID (based on timestamp)
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'Workout Complete!',
      body: 'You crushed $workoutName! $stats',
      notificationDetails: details,
    );
  }
  
  /// Shows a reminder notification for workouts or tips
  /// @param title - Notification title
  /// @param body - Notification content
  Future<void> showReminderNotification({
    required String title,
    required String body,
  }) async {
    // Ensure service is initialized
    if (!_isInitialized) await init();
    
    // Android notification channel for reminders
    // Separate channel from workout completions for different settings
    const androidDetails = AndroidNotificationDetails(
      'reminders',                   // Channel ID
      'Reminders',                   // Channel name
      channelDescription: 'Workout reminders and tips',
      importance: Importance.defaultImportance,  // Standard importance
      priority: Priority.defaultPriority,        // Standard priority
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    // Show notification with unique ID
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}