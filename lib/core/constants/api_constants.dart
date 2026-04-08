class AppConstants {
  static const String appNameEn = 'Muktinath Guest House';
  static const String appNameNp = 'मुक्तिनाथ गेस्ट हाउस';
  
  // गेस्ट हाउसको फिचरमा फोकस गरिएको ट्यागलाइन
  static const String appTagline = 'तपाईँको आरामदायी बसाईको सारथी';

  // १. सर्भर सेटिङ (Development र Production स्विच गर्न सजिलो)
  static const bool isProduction = false;
  static const String baseUrl = isProduction 
      ? "https://api.muktinathguesthouse.com" 
      : "http://192.168.1.100:8000"; // तपाईंको लोकल सर्भरको IP

  // २. Auth Endpoints
  static const String login = "$baseUrl/api/login";
  static const String register = "$baseUrl/api/register";
  static const String profile = "$baseUrl/api/user/profile";

  // ३. Booking & Room Endpoints
  static const String roomList = "$baseUrl/api/rooms";
  static const String bookingEndpoint = "$baseUrl/api/book";
  static const String myBookings = "$baseUrl/api/my-bookings";
  
  // ४. Home & Amenities Endpoints (पहिले प्रयोग भएको)
  static const String banners = "$baseUrl/api/banners";
  static const String amenities = "$baseUrl/api/amenities";

  // ५. Headers: टोकन बिना र टोकन सहितको लागि अलग-अलग
  static Map<String, String> commonHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
