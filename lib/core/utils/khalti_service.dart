import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'dart:developer';

class KhaltiPaymentService {
  /// मुख्य कार्य (Main Function to Start Payment)
  /// यो सेटअप गर्न main/app मा KhaltiScope प्रयोग गर्नुपर्छ।
  static void startPayment({
    required BuildContext context,
    required double amount, // रुपैयाँमा (In Rs.)
    required String productIdentity,
    required String productName,
    required Function(PaymentSuccessModel) onSuccess,
    required Function(PaymentFailureModel) onFailure,
  }) {
    // पैसामा रुपान्तरण गरिन्छ (Rs 1 = 100 Paisa)
    final int amountInPaisa = (amount * 100).toInt();

    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: amountInPaisa,
        productIdentity: productIdentity,
        productName: productName,
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.connectIPS,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: () {
        log("भुक्तानी रद्द गरियो (Payment Cancelled)");
      },
    );
  }
}
