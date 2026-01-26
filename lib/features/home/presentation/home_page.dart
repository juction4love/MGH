import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // IMPORTED

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String _frontDeskNumber = "9847634444";

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      debugPrint("Could not launch call");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 220.0,
          floating: false,
          pinned: true,
          backgroundColor: Colors.deepOrange,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("Muktinath Guesthouse"),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.orange.shade300),
                const Icon(Icons.landscape, size: 120, color: Colors.white24),
                Positioned(
                  bottom: 60,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                    child: const Text("⭐⭐⭐⭐⭐ Excellence", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // QUICK ACTIONS ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickAction(context, Icons.call, "Call Us", Colors.green, () {
                      _makePhoneCall(_frontDeskNumber); // CALL ACTION
                    }),
                    _buildQuickAction(context, Icons.map, "Map", Colors.blue, () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Opening Maps...")));
                    }),
                    _buildQuickAction(context, Icons.wifi, "Wi-Fi", Colors.orange, () {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wi-Fi: MuktinathGuest123")));
                    }),
                    _buildQuickAction(context, Icons.share, "Share", Colors.purple, () {}),
                  ],
                ),
                
                const SizedBox(height: 25),
                
                // PROMO BANNER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.indigo]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Special Offer! 🎉", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 5),
                      Text("Get 10% OFF on Deluxe Rooms this weekend.", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                const Text("Our Amenities", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                
                // AMENITIES GRID
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: [
                    _buildFeatureCard(Icons.wifi, "High-Speed Wi-Fi", Colors.blue),
                    _buildFeatureCard(Icons.ac_unit, "Air Conditioned", Colors.cyan),
                    _buildFeatureCard(Icons.restaurant, "Thakali Kitchen", Colors.orange),
                    _buildFeatureCard(Icons.local_parking, "Secure Parking", Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
        ],
      ),
    );
  }
}
