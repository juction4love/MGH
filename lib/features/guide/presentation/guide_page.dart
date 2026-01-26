import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chitwan Travel Guide"), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWeatherCard(),
          const SizedBox(height: 20),
          const Text("Top Attractions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildPlace(context, "Chitwan National Park", "15 km", "Home of the One-horned Rhino. Jungle Safari hub.", Icons.pets),
          _buildPlace(context, "Narayani River", "2 km", "Sunset views and boating.", Icons.water),
          _buildPlace(context, "Devghat Dham", "6 km", "Holy confluence of rivers.", Icons.temple_hindu),
          _buildPlace(context, "Jalbire Waterfall", "30 km", "Lamo Jharana - Best for swimming.", Icons.landscape),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.teal, Colors.green]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Bharatpur", style: TextStyle(color: Colors.white)),
            Text("28°C", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
            Text("Sunny & Humid", style: TextStyle(color: Colors.white70)),
          ]),
          Icon(Icons.wb_sunny, size: 50, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildPlace(BuildContext context, String title, String dist, String desc, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(icon, size: 36, color: Colors.deepOrange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(dist),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(desc, style: const TextStyle(color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Opening Maps...")));
              },
              icon: const Icon(Icons.map, size: 18),
              label: const Text("Get Directions"),
            ),
          )
        ],
      ),
    );
  }
}
