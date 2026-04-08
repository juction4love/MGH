import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mgh/core/utils/map_helper.dart';
import 'package:mgh/shared/widgets/powered_by_widget.dart';

class SupportHelpPage extends StatelessWidget {
  const SupportHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("सम्पर्क र मद्दत"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "तपाईँको बसाईलाई सहज बनाउन हामी सहयोग गर्न तयार छौँ।",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 25),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.local_hospital, color: Colors.red),
                  title: const Text("नजिकैको अस्पताल"),
                  subtitle: const Text("नक्सामा बाटो हेर्नुहोस्"),
                  onTap: () => MapHelper.openMap(), // गुगल म्याप एप खुल्छ
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: const Text("म्यानेजरलाई सम्पर्क"),
                  subtitle: const Text("९८४७६३४४४४"),
                  onTap: () => launchUrl(Uri.parse('tel:+9779847634444')), // सिधै कल लाग्छ
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PoweredByWidget(),
    );
  }
}
