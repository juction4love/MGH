import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SmartNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  /// १. स्मार्ट नोटिफिकेसन पठाउने (Send Smart Notification)
  /// यसले फोनको रिनर मोड (Silent/Vibrate) अनुसार नोटिफिकेसनको व्यवहार परिवर्तन गर्छ।
  static Future<void> showSmartNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    // २. फोनको वर्तमान मोड चेक गर्ने (Check current ringer status)
    RingerModeStatus ringerStatus;
    try {
       ringerStatus = await SoundMode.ringerModeStatus;
    } catch (e) {
       ringerStatus = RingerModeStatus.unknown;
    }

    // ३. यदि फोन साइलेन्ट वा भाइब्रेटमा छ भने 'Importance' र 'Priority' कम गर्ने
    // क्यान्सर अस्पतालमा आराम गरिरहेका बिरामीलाई डिस्टर्ब नगर्न यो फिचर उपयोगी छ।
    bool isQuiet = ringerStatus == RingerModeStatus.silent || 
                   ringerStatus == RingerModeStatus.vibrate;

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'smart_channel', 
      'Smart Patient Alerts',
      channelDescription: 'Quiet alerts when phone is in silent/vibrate mode.',
      importance: isQuiet ? Importance.low : Importance.max,
      priority: isQuiet ? Priority.low : Priority.high,
      playSound: !isQuiet,      // यदि साइलेन्ट छ भने आवाज ननिकाल्ने
      enableVibration: !isQuiet, // यदि साइलेन्ट छ भने भाइब्रेट नगर्ने
    );

    NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notifications.show(id, title, body, details);
  }
}
