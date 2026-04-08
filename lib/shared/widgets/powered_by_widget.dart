import 'package:flutter/material.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100], // हल्का ब्याकग्राउन्ड
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
      ),
      child: const Text(
        "Powered by: Bimal Tech Solution",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
