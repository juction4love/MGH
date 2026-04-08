import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mgh/shared/widgets/powered_by_widget.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 10),
              const Text(
                "भुक्तानी र बुकिङ सफल!", 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text("म्यानेजरसँग कुरा गर्न आवश्यक छ?"),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse('tel:+9779847634444')),
                icon: const Icon(Icons.phone),
                label: const Text("९८४७६३४४४४ मा कल गर्नुहोस्"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text("होम स्क्रिनमा फर्कनुहोस्"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PoweredByWidget(),
    );
  }
}
