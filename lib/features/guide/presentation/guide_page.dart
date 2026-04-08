import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Maps खोल्नका लागि
import 'package:mgh/core/providers/language_provider.dart';
import 'package:mgh/core/providers/language_provider.dart';


class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  // --- Google Maps मा लोकेसन खोल्ने फङ्सन ---
  Future<void> _openMap(String locationName, BuildContext context, bool isNe) async {
    // Google Maps को Search URL
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$locationName";
    final Uri url = Uri.parse(googleMapsUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isNe ? "नक्सा खोल्न सकिएन!" : "Could not open maps!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    bool isNe = langProvider.currentLocale.languageCode == 'ne';

    return Scaffold(
      appBar: AppBar(
        title: Text(isNe ? "चितवन भ्रमण गाइड" : "Chitwan Travel Guide"), 
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWeatherCard(context, isNe),
          const SizedBox(height: 24),
          Text(
            isNe ? "प्रमुख आकर्षणहरू" : "Top Attractions", 
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 12),
          
          _buildPlace(
            context, 
            isNe ? "चितवन राष्ट्रिय निकुञ्ज" : "Chitwan National Park", 
            "15 km", 
            isNe ? "एकसिंगे गैंडाको घर। जङ्गल सफारीको लागि प्रख्यात।" : "Home of the One-horned Rhino. Jungle Safari hub.", 
            Icons.pets,
            isNe,
            "Chitwan National Park, Nepal" // Google Maps Query
          ),
          _buildPlace(
            context, 
            isNe ? "नारायणी नदी" : "Narayani River", 
            "2 km", 
            isNe ? "सूर्यास्तको दृश्य र डुङ्गा सयरको लागि उत्तम।" : "Sunset views and boating.", 
            Icons.water,
            isNe,
            "Narayani River Bank, Bharatpur"
          ),
          _buildPlace(
            context, 
            isNe ? "देवघाट धाम" : "Devghat Dham", 
            "6 km", 
            isNe ? "नदीहरूको पवित्र संगम र धार्मिक स्थल।" : "Holy confluence of rivers and religious site.", 
            Icons.temple_hindu,
            isNe,
            "Devghat Dham, Chitwan"
          ),
          _buildPlace(
            context, 
            isNe ? "जलबिरे झरना" : "Jalbire Waterfall", 
            "30 km", 
            isNe ? "लामो झरना - पौडी खेल्न र पिकनिकको लागि उत्तम।" : "Lamo Jharana - Best for swimming and picnic.", 
            Icons.landscape,
            isNe,
            "Jalbire Waterfall (Lamo Jharana), Mugling"
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, bool isNe) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.orange.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                isNe ? "भरतपुर" : "Bharatpur", 
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)
              ),
              const SizedBox(height: 4),
              const Text("28°C", style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold)),
              Text(
                isNe ? "घमाइलो र ओसिलो" : "Sunny & Humid", 
                style: const TextStyle(color: Colors.white70, fontSize: 14)
              ),
            ]
          ),
          const Icon(Icons.wb_sunny, size: 64, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildPlace(BuildContext context, String title, String dist, String desc, IconData icon, bool isNe, String mapQuery) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        shape: const Border(),
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange.withOpacity(0.1),
          child: Icon(icon, color: Colors.deepOrange, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        subtitle: Text(
          isNe ? "$dist टाढा" : "$dist away", 
          style: TextStyle(color: Colors.grey.shade600)
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(desc, style: const TextStyle(fontSize: 15, height: 1.4)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openMap(mapQuery, context, isNe), // यहाँ नक्सा खोलिन्छ
                icon: const Icon(Icons.near_me, size: 18),
                label: Text(isNe ? "दिशा पत्ता लगाउनुहोस्" : "GET DIRECTIONS"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
