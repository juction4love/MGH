
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  final plugin = FlutterLocalNotificationsPlugin();
  print("Plugin type: ${plugin.runtimeType}");
  // We can't really call initialize here without settings but we can check if it takes named or positional via reflection in a way? No.
  // But we can try to call it with a fake settings and see.
}
