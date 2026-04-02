import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  
  Future<void> init() async {
    if (_isInitialized) return;
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _plugin.initialize(settings: settings);
    _isInitialized = true;
  }
  
  Future<void> showWorkoutCompleteAlert({
    required String workoutName,
    required String stats,
  }) async {
    if (!_isInitialized) await init();
    
    const androidDetails = AndroidNotificationDetails(
      'workout_complete',
      'Workout Completion',
      channelDescription: 'Notifications when you complete a workout',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'Workout Complete!',
      body: 'You crushed $workoutName! $stats',
      notificationDetails: details,
    );
  }
  
  Future<void> showReminderNotification({
    required String title,
    required String body,
  }) async {
    if (!_isInitialized) await init();
    
    const androidDetails = AndroidNotificationDetails(
      'reminders',
      'Reminders',
      channelDescription: 'Workout reminders and tips',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}