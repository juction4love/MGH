import 'package:flutter/material.dart';
import 'package:mgh/core/utils/map_helper.dart';
import 'package:mgh/shared/widgets/powered_by_widget.dart';

class PharmacyNearbyPage extends StatelessWidget {
  const PharmacyNearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("नजिकैको फार्मेसी खोज्नुहोस्")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_pharmacy, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "तपाईँको लोकेसन वरिपरिको औषधि पसल हेर्नुहोस्",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => MapHelper.findNearbyPharmacy(),
              icon: const Icon(Icons.map),
              label: const Text("गुगल म्यापमा हेर्नुहोस्"),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const PoweredByWidget(),
    );
  }
}
