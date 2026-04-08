import 'dart:convert';
import 'package:flutter/foundation.dart'; 
import 'package:http/http.dart' as http;

// Relative path हटाएर package path प्रयोग गरिएको छ ताकि build error नआओस्
import 'package:mgh/core/constants/api_constants.dart'; 

class HomeRepository {
  final http.Client _client;

  HomeRepository({http.Client? client}) : _client = client ?? http.Client();

  /// १. होम पेजका ब्यानर र अफरहरू तान्ने (Localization सहित)
  Future<List<Map<String, dynamic>>> fetchHomeBanners({bool isNepali = true}) async {
    try {
      final response = await _client.get(
        Uri.parse("${AppConstants.baseUrl}/api/banners"),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception("Banners load failed with status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Home Banners Error: $e");
      // API फेल हुँदा वा इन्टरनेट नहुँदा पनि आकर्षक डिफल्ट ब्यानर देखाउने
      return [
        {
          "title": isNepali ? "मुक्तिनाथ गेष्टहाउसमा स्वागत छ! 🎉" : "Welcome to MGH! 🎉",
          "description": isNepali 
              ? "बीपी क्यान्सर अस्पताल नजिकै, शान्त र सुरक्षित बसाई।" 
              : "Safe and peaceful stay near BP Cancer Hospital."
        }
      ];
    }
  }

  /// २. होटलका सुविधाहरू (Amenities) तान्ने
  Future<List<String>> fetchAmenities({bool isNepali = true}) async {
    try {
      final response = await _client.get(
        Uri.parse("${AppConstants.baseUrl}/api/amenities"),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>();
      }
      return _getFallbackAmenities(isNepali);
    } catch (e) {
      debugPrint("Amenities Error: $e");
      // इन्टरनेट नहुँदा यो फङ्सनले ह्वीलचेयर र एम्बुलेन्स सेवाहरू पठाउँछ
      return _getFallbackAmenities(isNepali);
    }
  }

  /// ३. विशेष स्वास्थ्य र सहायता सेवाहरू (Fallback Method)
  List<String> _getFallbackAmenities(bool isNepali) {
    return isNepali 
        ? [
            "बीपी क्यान्सर अस्पताल विशेष सहुलियत",
            "नि:शुल्क ह्वीलचेयर (Wheelchair) सुविधा",
            "एम्बुलेन्स (Ambulance) सेवा समन्वय",
            "अपाङ्ग, वृद्ध र बच्चालाई व्यक्तिगत सहयोग",
            "कोठामै तातो र ताजा खाना (Food on Call)",
            "२४ घण्टा तातो पानी र वाइफाइ"
          ]
        : [
            "BP Cancer Hospital Special Discount",
            "Free Wheelchair Facility",
            "Ambulance Service Coordination",
            "Personal Help for Elderly & Children",
            "Fresh Food on Call",
            "24-hour Hot Water & WiFi"
          ];
  }
}
