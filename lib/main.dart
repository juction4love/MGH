import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mgh/app.dart';
import 'package:mgh/core/di/service_locator.dart';
import 'package:mgh/features/rooms/logic/booking_provider.dart';
import 'package:mgh/core/utils/notification_service.dart';
import 'package:mgh/core/providers/language_provider.dart';

void main() async {
  // १. Flutter Framework सुरु भएको सुनिश्चित गर्ने
  WidgetsFlutterBinding.ensureInitialized();
  
  // २. Dependency Injection (Setup Locator)
  // सुचारु रूपमा सबै रिपोजिटरीहरू र सर्भिसहरू लोड गर्छ।
  await setupLocator(); 
  
  // ३. Notification Service सुरु गर्नुहोस् (Initialize)
  await sl<NotificationService>().initNotification();
  
  // ४. एप रन गर्ने (MultiProvider सँगै)
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        // अन्य Providers यहाँ थप्न सकिन्छ।
      ],
      child: const MuktinathGuestHouseApp(),
    ),
  );
}
