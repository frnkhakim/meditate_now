import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
    InitializationSettings(
      android: android,
    );

    await notifications.initialize(
      settings,
    );
  }

  static Future<void>
  requestPermission() async {

    notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void>
  showTestNotification() async {

    const details =
    NotificationDetails(
      android: AndroidNotificationDetails(
        'meditation_channel',
        'Meditation Reminders',
        icon: '@mipmap/ic_launcher',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await notifications.show(
      0,
      'Meditation Time 🧘',
      'Take a few minutes to relax.',
      details,
    );
  }
}