import 'package:flutter/material.dart';
import '../data/models/room_model.dart';

class BookingProvider extends ChangeNotifier {
  RoomModel? _selectedRoom;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  
  // पाहुनाको सक्रिय बुकिङ डाटा (Active Booking Data)
  dynamic _currentBooking; 
  dynamic get currentBooking => _currentBooking;

  RoomModel? get selectedRoom => _selectedRoom;
  
  void selectRoom(RoomModel room) {
    _selectedRoom = room;
    // डेमोका लागि कोठा सेलेक्ट गर्दा यसलाई सक्रिय बुकिङ मान्न सकिन्छ
    _currentBooking = room; 
    notifyListeners();
  }

  void setDates(DateTime start, DateTime end) {
    _checkInDate = start;
    _checkOutDate = end;
    notifyListeners();
  }

  /// खाना वा अन्य सेवाहरूको अर्डर बिलमा जोड्ने (Add Order to Bill)
  void addOrder(String name, double price) {
    // यहाँ अर्डरलाई लिस्टमा जोड्ने वा सिधै डेटाबेसमा पठाउने लजिक राख्न सकिन्छ।
    // उदाहरणका लागि: _orders.add(Order(name, price));
    debugPrint("MGH Ordering: $name - रू $price");
    notifyListeners();
  }

  double get totalAmount {
    if (_selectedRoom == null) return 0.0;
    return _selectedRoom!.price; // यहाँ दिन अनुसार गुणन गर्ने लजिक थप्न सकिन्छ
  }
}
