import 'package:flutter/foundation.dart';
import 'package:mgh/features/rooms/data/models/room_model.dart';
import 'package:mgh/features/rooms/data/sources/remote/booking_remote_data_source.dart';

/// १. रिपोजिटरीले डेटाको स्रोत (Remote/Local) सँग समन्वय गर्छ।
class BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepository({required this.remoteDataSource});

  /// १. सबै उपलब्ध कोठाहरूको सूची तान्ने (Fetch All Rooms)
  /// स्वास्थ्य र बिरामीको प्राथमिकता अनुसार डाटा प्राप्त गर्दछ।
  Future<List<RoomModel>> fetchAllRooms() async {
    try {
      final rooms = await remoteDataSource.fetchAllRooms();
      // यहाँ थप बिजनेस लजिक राख्न सकिन्छ (जस्तै: कुन कोठा उत्कृष्ट छ?)
      return rooms;
    } catch (e) {
      debugPrint("Fetch Rooms Error: $e, fallback to Dummy Data.");
      // अस्पताल/बिरामीको लागि सान्दर्भिक डमी डेटा फर्काउने
      return RoomModel.dummyRooms;
    }
  }

  /// २. नयाँ बुकिङ पठाउने (Post Booking Request)
  /// यसमा बिरामीको आईडी वा विशेष आवश्यकताहरू (Wheelchair, etc.) पठाउन सकिन्छ।
  Future<bool> bookRoom(String roomId, Map<String, dynamic> bookingDetails) async {
    try {
      return await remoteDataSource.bookRoom(roomId, bookingDetails);
    } catch (e) {
      debugPrint("Booking Request Failed (Repository): $e");
      return false;
    }
  }
}
