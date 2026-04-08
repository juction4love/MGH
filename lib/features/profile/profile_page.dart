import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.teal[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 15),
            const Text(
              "MGH आदरणीय अतिथि",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("९८४७६३४४४४", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            
            _profileTile(
              context, 
              Icons.rate_review, 
              "अनुभव बाँड्नुहोस् (Feedback)", 
              () => _showFeedbackDialog(context)
            ),
            _profileTile(context, Icons.history, "बुकिङ इतिहास (History)", () {}),
            _profileTile(context, Icons.settings, "सेटिङ (Settings)", () {}),
            
            // नयाँ थपिएको: एप सेयर गर्ने विकल्प
            _profileTile(
              context, 
              Icons.share, 
              "एप सेयर गर्नुहोस् (Share App)", 
              () {
                Share.share(
                  "मुक्तिनाथ गेस्ट हाउसमा आरामदायी बसाईका लागि हाम्रो एप डाउनलोड गर्नुहोस्! 🙏✨ \nडाउनलोड लिंक: https://muktinathguesthouse.com/app",
                );
              }
            ),
            
            const Divider(indent: 20, endIndent: 20),
            _profileTile(context, Icons.logout, "लग-आउट (Logout)", () {}, iconColor: Colors.red),
            
            const SizedBox(height: 30),
            // एपको भर्सन जानकारी
            const Text(
              "Version v1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _profileTile(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color iconColor = Colors.teal}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// पाहुनाका लागि फिडब्याक र स्टार रेटिङ डायलग (Feedback & Star Rating Dialog)
  void _showFeedbackDialog(BuildContext context) {
    int selectedRating = 5; 

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("हाम्रो सेवा कस्तो लाग्यो?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return InkWell(
                      onTap: () {
                        setDialogState(() {
                          selectedRating = index + 1;
                        });
                      },
                      child: Icon(
                        index < selectedRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 38,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                const Text(
                  "तपाईँको सानो सुझाव वा प्रशंसाले हामीलाई अझ राम्रो सेवा दिन मद्दत गर्नेछ।",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                ),
                const SizedBox(height: 15),
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "आफ्नो अनुभव यहाँ लेख्नुहोस्...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text("अहिले पर्दैन"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[700]),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$selectedRating तारा रेटिङका लागि धन्यवाद!"),
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
                child: const Text("पठाउनुहोस्", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }
      ),
    );
  }
}
