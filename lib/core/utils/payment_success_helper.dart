import 'package:url_launcher/url_launcher.dart';

class PaymentSuccessHelper {
  static const String managerPhone = "+9779847634444";

  static Future<void> notifyManager(String guestName, String roomNo, double amount) async {
    final String message = 
        "MGH Booking: $guestName ले कोठा नं $roomNo को लागि रू $amount भुक्तानी गर्नुभएको छ।";
    
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: managerPhone,
      queryParameters: <String, String>{
        'body': message,
      },
    );

    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      // SMS खोल्न नसकिएमा यहाँ एरर ह्यान्डल गर्न सकिन्छ
    }
  }
}
