class GuestBooking {
  final String id;
  final String guestName;
  final String phoneNumber;
  final DateTime checkInTime;
  final double roomRatePerNight;
  List<OrderItem> orders;

  GuestBooking({
    required this.id,
    required this.guestName,
    required this.phoneNumber,
    required this.checkInTime,
    required this.roomRatePerNight,
    this.orders = const [],
  });

  /// कति दिन बस्यो गणना गर्ने (Real-time stay duration)
  /// क्यान्सर अस्पताल नजिक भएकोले कम्तीमा १ दिन गणना गरिन्छ।
  int get totalNights {
    int nights = DateTime.now().difference(checkInTime).inDays;
    return (nights <= 0) ? 1 : nights;
  }

  /// खाजा वा खानाको कुल रकम गणना गर्ने
  double get totalOrderAmount => orders.fold(0, (sum, item) => sum + item.price);

  /// कोठा शुल्क र खानाको कुल रकम (Grand Total)
  double get grandTotal => (totalNights * roomRatePerNight) + totalOrderAmount;
}

class OrderItem {
  final String itemName;
  final double price;
  final DateTime orderTime;

  OrderItem({
    required this.itemName, 
    required this.price,
    required this.orderTime,
  });
}
