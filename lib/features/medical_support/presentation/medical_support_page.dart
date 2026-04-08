import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// १. यो पेजले बीपी क्यान्सर अस्पताल आउने बिरामी र तिनका आफन्तहरूलाई आकस्मिक समयमा मद्दत गर्छ।
class MedicalSupportPage extends StatelessWidget {
  const MedicalSupportPage({super.key});

  /// २. सिधै कल गर्ने फसन (One-Tap Direct Calling)
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint("Could not launch $phoneNumber: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // हल्का पृष्ठभूमि
      appBar: AppBar(
        title: const Text("Emergency & Hospital Guide", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _makeCall("9847634444"), // म्यानेजरको नम्बर
        backgroundColor: Colors.red,
        icon: const Icon(Icons.call, color: Colors.white),
        label: const Text("Call Manager", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ३. तत्काल मद्दत (Emergency Contacts Section)
            _buildSectionTitle("तत्काल मद्दत (Emergency)"),
            _buildEmergencyCard(
              "हस्पिटल इमर्जेन्सी (BP Cancer)", 
              "०५६-५२४५०१", 
              Icons.local_hospital, 
              Colors.red[800]!
            ),
            _buildEmergencyCard(
              "एम्बुलेन्स सेवा (Ambulance)", 
              "१०२", 
              Icons.airport_shuttle, 
              Colors.orange[800]!
            ),

            const SizedBox(height: 25),

            // ४. अस्पतालको जानकारी (Hospital Guide Section)
            _buildSectionTitle("अस्पताल मार्गनिर्देशन (Hospital Guide)"),
            _buildGuideTile(
              "ओपिडी (OPD) समय", 
              "बिहान ९:०० देखि दिउँसो ४:०० सम्म", 
              Icons.access_time
            ),
            _buildGuideTile(
              "टिकट काउन्टर र सोधपुछ", 
              "मुख्य गेटको बायाँ पट्टि (Main Gate)", 
              Icons.confirmation_number
            ),
            _buildGuideTile(
              "फार्मेसी (२४ घण्टा खुला)", 
              "अस्पतालको ईमर्जेन्सी गेट नजिकै", 
              Icons.medical_services
            ),

            const SizedBox(height: 25),

            // ५. रगतको आवश्यकता (Blood Bank Information)
            _buildBloodBankCard(),

            const SizedBox(height: 35),
            
            // ६. होटल स्टाफको मद्दत (MGH Staff Support Promise)
            _buildStaffSupportCard(),
            
            const SizedBox(height: 100), // स्क्रोलिङका लागि अतिरिक्त ठाउँ
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
      ),
    );
  }

  Widget _buildEmergencyCard(String title, String phone, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1), 
          radius: 25,
          child: Icon(icon, color: color, size: 28)
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(phone, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        trailing: ElevatedButton(
          onPressed: () => _makeCall(phone),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text("Call Now"),
        ),
      ),
    );
  }

  Widget _buildGuideTile(String title, String desc, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal[700], size: 28),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodBankCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: const Row(
        children: [
          Icon(Icons.bloodtype, color: Colors.red, size: 45),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("रगत आवश्यक परेमा (Blood Bank)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                SizedBox(height: 5),
                Text("क्षेत्रीय रक्तसञ्चार केन्द्र: ०५६-५२१३१३", style: TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffSupportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.teal.shade900, Colors.teal.shade700], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          const Icon(Icons.support_agent, color: Colors.white, size: 35),
          const SizedBox(height: 12),
          const Text(
            "होटल स्टाफको विशेष सहयोग",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 8),
          const Text(
            "तपाईँलाई हस्पिटल लैजान, इमर्जेन्सी रगतको जोहो गर्न वा अन्य कागजी प्रक्रियामा मद्दत गर्न हामी २४सै घण्टा तयार छौँ।",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 15),
          TextButton.icon(
            onPressed: () => _makeCall("9847634444"),
            icon: const Icon(Icons.call, color: Colors.white, size: 18),
            label: const Text("सम्पर्क: ९८४७६३४४४४", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
