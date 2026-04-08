import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // एन्ड्रोइडका लागि नोटिफिकेसन आइकन सेटअप
    // याद गर्नुहोस्: 'ic_notification' फाइल android/app/src/main/res/drawable/ मा हुनुपर्छ
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_notification');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, 
        iOS: const DarwinInitializationSettings());
        
    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'mgh_channel_id',
          'Muktinath Guest House Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: 'ic_notification', // यहाँ लोगो काम गर्छ
        ),
      ),
    );
  }
}
