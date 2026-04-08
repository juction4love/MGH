import 'package:flutter/material.dart';
import 'package:mgh/shared/widgets/powered_by_widget.dart';
import 'package:mgh/core/utils/payment_success_helper.dart';
import 'booking_success_page.dart';

class PaymentMethodPage extends StatelessWidget {
  final double amount;
  const PaymentMethodPage({super.key, required this.amount});

  // eSewa Payment Simulation
  Future<bool> startEsewaPayment(double amount) async {
    // यहाँ eSewa SDK वा Webview Integrate गर्ने लजिक हुन्छ
    await Future.delayed(const Duration(seconds: 2)); // सिमुलेसनका लागि २ सेकेन्ड कुर्नुहोस्
    return true; // सफल भएको मान्दा
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("भुक्तानीको माध्यम छान्नुहोस्")),
      body: Column(
        children: [
          _buildAmountHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _paymentTile(context, "eSewa", "assets/images/esewa.png", Colors.green, () async {
                  // १. यहाँ eSewa को भुक्तानी प्रक्रिया सुरु हुन्छ
                  bool isSuccess = await startEsewaPayment(amount); 

                  if (isSuccess) {
                    // २. सफल भएमा म्यानेजरलाई जानकारी पठाउने
                    await PaymentSuccessHelper.notifyManager("Atithi", "101", amount);
                    
                    // ३. पाहुनालाई सफलताको म्यासेज देखाउने र अर्को फेजमा लैजाने
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (_) => const BookingSuccessPage()),
                      );
                    }
                  }
                }),
                _paymentTile(context, "Khalti", "assets/images/khalti.png", Colors.deepPurple, () {
                  // Khalti Integration Logic
                }),
                _paymentTile(context, "ConnectIPS", "assets/images/ips.png", Colors.blue[900]!, () {
                  // ConnectIPS Logic
                }),
                _paymentTile(context, "Mobile Banking / Wallet", "assets/images/bank.png", Colors.orange, () {
                  // Bank Integration Logic
                }),
              ],
            ),
          ),
          const PoweredByWidget(),
        ],
      ),
    );
  }

  Widget _buildAmountHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.blueGrey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("तिर्नुपर्ने जम्मा रकम:", style: TextStyle(fontSize: 16)),
          Text("रू $amount", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _paymentTile(BuildContext context, String title, String assetPath, Color color, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(
          assetPath, 
          width: 40, 
          errorBuilder: (c, e, s) => Icon(Icons.payment, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
