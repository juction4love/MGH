import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingCallButton extends StatelessWidget {
  const FloatingCallButton({super.key});

  // म्यानेजरको फोन नम्बर यहाँ राख्नुहोस्
  final String managerPhone = "+97798XXXXXXXX"; 

  Future<void> _makeCall() async {
    final Uri url = Uri.parse('tel:$managerPhone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("कल गर्न सकिएन");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _makeCall,
      backgroundColor: Colors.green,
      elevation: 10,
      tooltip: 'म्यानेजरलाई कल गर्नुहोस्',
      child: const Icon(Icons.call, color: Colors.white, size: 30),
    );
  }
}
