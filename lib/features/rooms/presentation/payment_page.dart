import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/booking_provider.dart';
import '../../../core/utils/khalti_service.dart';
import '../../../shared/widgets/powered_by_widget.dart';
import '../../../core/utils/notification_service.dart';
import '../../../core/di/service_locator.dart';
import 'payment_method_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("भुक्तानी (Payment)")),
      body: Column(
        children: [
          ListTile(
            title: const Text("जम्मा रकम"),
            trailing: Text("रू ${booking.totalAmount}", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, minimumSize: const Size(double.infinity, 55)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentMethodPage(amount: booking.totalAmount),
                  ),
                );
              },
              child: const Text("भुक्तानी अगाडि बढाउनुहोस्", style: TextStyle(color: Colors.white)),
            ),
          ),
          const PoweredByWidget(),
        ],
      ),
    );
  }
}
