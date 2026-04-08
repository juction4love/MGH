import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const NoInternetWidget({super.key, required this.onRetry});

  Future<void> _callManager() async {
    final Uri url = Uri.parse('tel:+9779847634444');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "इन्टरनेट भेटिएन (No Internet)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "कृपया तपाईँको इन्टरनेट कनेक्सन चेक गर्नुहोस् वा सिधै म्यानेजरलाई सम्पर्क गर्नुहोस्।",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("फेरि प्रयास गर्नुहोस् (Retry)"),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _callManager,
              icon: const Icon(Icons.call, color: Colors.green),
              label: const Text("सिधै फोन गर्नुहोस् (+977 9847634444)", style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
