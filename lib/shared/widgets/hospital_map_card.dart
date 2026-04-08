import 'package:flutter/material.dart';

class HospitalMapCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HospitalMapCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.local_hospital, color: Colors.red, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("नजिकैको अस्पताल र फार्मेसी हेर्नुहोस्"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
