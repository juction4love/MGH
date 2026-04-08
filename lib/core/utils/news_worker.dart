import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

class NewsWorker {
  static const List<String> feeds = [
    "https://www.onlinekhabar.com/feed",
    "https://setopati.com/feed",
    "https://ekantipur.com/rss/news"
  ];

  /// १. ब्याकग्राउण्डबाट समाचार तान्ने र नोटिफिकेसन दिने
  static Future<void> fetchAndNotify() async {
    final myXml = Xml2Json();
    final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

    for (var url in feeds) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          myXml.parse(response.body);
          
          // २. पार्कर (Parker) फम्र्याटमा JSON बदल्ने
          var jsonStr = myXml.toParker();
          var data = json.decode(jsonStr);
          
          // ३. समाचारका लेखहरू (Articles) निकाल्ने
          // RSS संरचना अनुसार 'rss' -> 'channel' -> 'item' भित्र समाचार हुन्छ।
          var articles = data['rss']?['channel']?['item'];

          if (articles != null) {
            String latestTitle = "";

            if (articles is List && articles.isNotEmpty) {
              // पहिलो समाचारको शीर्षक लिने
              latestTitle = articles[0]['title']?.toString() ?? "";
            } else if (articles is Map) {
              // यदि एउटा मात्र समाचार छ भने
              latestTitle = articles['title']?.toString() ?? "";
            }

            if (latestTitle.isNotEmpty) {
               // ४. नोटिफिकेसन देखाउने (Show Alert)
               await _showNotification(notifications, "ताजा समाचार (Breaking News)", latestTitle);
               break; // एउटा सफल भएपछि अर्कोमा नजाने
            }
          }
        }
      } catch (e) {
        print("News worker error: $e");
      }
    }
  }

  /// ५. नोटिफिकेसन पठाउने फङ्सन
  static Future<void> _showNotification(FlutterLocalNotificationsPlugin plug, String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'news_id', 'MGH Nepal News',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(''), // लामो समाचार शीर्षकका लागि
      ),
    );
    await plug.show(id: 0, title: title, body: body, notificationDetails: details);
  }
}
