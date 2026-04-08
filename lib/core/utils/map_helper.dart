import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  // मुक्तिनाथ गेस्ट हाउसको कोअर्डिनेट्स (Coordinates)
  static const double latitude = 27.6833;
  static const double longitude = 84.4333;

  static Future<void> openMap() async {
    final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri url = Uri.parse(googleUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'नक्सा खोल्न सकिएन (Could not open the map).';
    }
  }

  static Future<void> findNearbyPharmacy() async {
    // प्रयोगकर्ताको वरपर फार्मेसी खोज्नका लागि
    const String pharmacyUrl = 'https://www.google.com/maps/search/pharmacy+near+me';
    final Uri url = Uri.parse(pharmacyUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
