import 'package:flutter/material.dart';
import 'package:mgh/core/constants/api_constants.dart';
import 'package:mgh/shared/widgets/powered_by_widget.dart';
import 'package:mgh/features/rooms/presentation/room_list_page.dart';
import 'package:mgh/features/medical_support/presentation/medical_support_page.dart';
import 'package:mgh/features/dining/presentation/dining_page.dart';
import 'package:mgh/features/home/presentation/support_help_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appNameNp),
        actions: [IconButton(icon: const Icon(Icons.notifications_active), onPressed: () {})],
      ),
      body: Column(
        children: [
          _buildBanner(), // गेस्ट हाउसको आकर्षक ब्यानर
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _guestActionCard(context, Icons.bed, "कोठा बुकिङ", Colors.blue, 
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomListPage()))),
                _guestActionCard(context, Icons.restaurant, "खाजा / खाना", Colors.orange,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiningPage()))),
                _guestActionCard(context, Icons.map, "घुम्ने ठाउँहरू", Colors.green, () {}),
                _guestActionCard(context, Icons.medical_services, "मेडिकल सहयोग", Colors.red,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalSupportPage()))),
                _guestActionCard(context, Icons.wifi, "वाइफाइ सेटअप", Colors.purple, () {}),
                _guestActionCard(context, Icons.support_agent, "सम्पर्क / मद्दत", Colors.teal, 
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportHelpPage()))),
              ],
            ),
          ),
          const PoweredByWidget(),
        ],
      ),
    );
  }

  Widget _guestActionCard(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/images/gh_banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
        ),
        child: const Text("शान्त र आरामदायी बसाई", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
