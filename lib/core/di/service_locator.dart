import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mgh/features/rooms/data/repository/booking_repository.dart';
import 'package:mgh/features/rooms/data/sources/remote/booking_remote_data_source.dart';
import 'package:mgh/core/utils/notification_service.dart';

final sl = GetIt.instance;

/// एपमा प्रयोग हुने सबै डिपेंडेन्सीहरू यहाँ दर्ता गरिन्छ।
Future<void> setupLocator() async {
  // ०. External (बाहिरी लाइब्रेरीहरू)
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // १. Sources & Data Providers (डेटाका स्रोतहरू)
  // यहाँ abstract class लाई यसको implementation सँग रजिस्टर गरिन्छ।
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(client: sl()),
  );

  // २. Repositories (रिपोजिटरीहरू)
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepository(remoteDataSource: sl()),
  );

  // ३. Services (सेवाहरू)
  sl.registerLazySingleton<NotificationService>(() => NotificationService());

  // थप फिचरका रिपोजिटरीहरू यहाँ थप्न सकिन्छ।
}
