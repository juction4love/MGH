import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mgh/core/constants/app_colors.dart';
import 'package:mgh/core/providers/language_provider.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  Future<void> _makeCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    bool isNe = langProvider.currentLocale.languageCode == 'ne';

    return Scaffold(
      appBar: AppBar(
        title: Text(isNe 
          ? "आपतकालीन सम्पर्क (Emergency)" 
          : "Emergency Contacts"),
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEmergencyCard(
            context,
            isNe ? "बीपी मेमोरियल क्यान्सर अस्पताल" : "BP Memorial Cancer Hospital",
            "056-524501",
            Icons.local_hospital,
          ),
          _buildEmergencyCard(
            context,
            isNe ? "चितवन मेडिकल कलेज" : "Chitwan Medical College",
            "056-532933",
            Icons.medical_services,
          ),
          _buildEmergencyCard(
            context,
            isNe ? "एम्बुलेन्स सेवा" : "Ambulance Service",
            "9847634444", // Front Desk Placeholder
            Icons.airport_shuttle,
          ),
          _buildEmergencyCard(
            context,
            isNe ? "मुक्तिनाथ गेष्टहाउस (फ्रन्ट डेस्क)" : "MGH (Front Desk)",
            "9847634444",
            Icons.room_service,
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard(BuildContext context, String name, String phone, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary,
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(phone, style: const TextStyle(fontSize: 15, color: Colors.blueAccent)),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.call, color: AppColors.success),
            onPressed: () => _makeCall(phone),
          ),
        ),
      ),
    );
  }
}
