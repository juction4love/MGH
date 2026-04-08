import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class WhatsAppService {
  /// १. WhatsApp Intent (निःशुल्क र सजिलो माध्यम)
  /// यसले ह्वाट्सएप एप खोल्छ र बिलको विवरण 'Pre-filled' गरिदिन्छ।
  /// गेष्टहाउसको लागि यो सबैभन्दा धेरै प्रयोग हुने र निःशुल्क उपाय हो।
  static Future<void> sendInvoiceIntent({
    required String recipientPhone,
    required String guestName,
    required String totalAmount,
    required String bookingId,
  }) async {
    // नेपालीमा प्रोफेशनल बिल म्यासेज
    final String message = "नमस्ते $guestName! 🙏\n\n🏨 *मुक्तिनाथ गेष्टहाउस* - बुकिङ इनभ्वाइस\n\n🆔 बुकिङ ID: $bookingId\n💰 जम्मा रकम: Rs. $totalAmount\n\nतपाईँको बसाई सुखद रहोस्! थप मद्दतका लागि सम्पर्क गर्नुहोला।";
    
    // अन्तर्राष्ट्रिय फर्म्याटमा नम्बर (उदा: 9779847634444)
    String cleanedPhone = recipientPhone.replaceAll(RegExp(r'\D'), '');
    if (!cleanedPhone.startsWith('977')) {
      cleanedPhone = "977$cleanedPhone";
    }

    final String whatsappUrl = "https://wa.me/$cleanedPhone?text=${Uri.encodeComponent(message)}";
    final Uri url = Uri.parse(whatsappUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      debugPrint("WhatsApp Intent Error: $e");
    }
  }

  /// ३. सामान्य प्रयोगको लागि (Wrapper)
  Future<void> sendInvoice({
    required String recipientPhone,
    required String guestName,
    required String totalAmount,
    required String bookingId,
  }) async {
    await sendInvoiceIntent(
      recipientPhone: recipientPhone,
      guestName: guestName,
      totalAmount: totalAmount,
      bookingId: bookingId,
    );
  }

  /// २. WhatsApp Cloud API (व्यावसायिक र स्वचालित - पछिको लागि)
  Future<void> sendCloudInvoice({
    required String recipientPhone,
    required String guestName,
    required String totalAmount,
    required String bookingId,
  }) async {
    debugPrint("WhatsApp Cloud API initialization...");
  }
}
