import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WifiSetupPage extends StatefulWidget {
  const WifiSetupPage({super.key});

  @override
  State<WifiSetupPage> createState() => _WifiSetupPageState();
}

class _WifiSetupPageState extends State<WifiSetupPage> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true; // पासवर्ड लुकाउन वा देखाउन

  @override
  void initState() {
    super.initState();
    _loadCurrentWifi();
  }

  // पुराना विवरणहरू SharedPreferences बाट लोड गर्ने
  void _loadCurrentWifi() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ssidController.text = prefs.getString('wifi_ssid') ?? "";
      _passController.text = prefs.getString('wifi_pass') ?? "";
    });
  }

  // विवरणहरू सुरक्षित गर्ने
  void _saveWifi() async {
    final ssid = _ssidController.text.trim();
    final pass = _passController.text.trim();

    if (ssid.isEmpty || pass.isEmpty) {
      _showSnackBar("कृपया वाइफाइ नाम र पासवर्ड दुवै भर्नुहोस्!", Colors.red);
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wifi_ssid', ssid);
      await prefs.setString('wifi_pass', pass);
      
      if (mounted) {
        _showSnackBar("वाइफाइ विवरण सफलतापूर्वक अपडेट भयो!", Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      _showSnackBar("अपडेट गर्दा समस्या आयो!", Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wifi Settings"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.wifi_lock_rounded, size: 100, color: Colors.deepOrange),
            const SizedBox(height: 10),
            const Text(
              "Setup Guest Wi-Fi",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "यो विवरण पाहुनाहरूले आफ्नो मोबाइलमा देख्नेछन्।",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            
            // Wi-Fi Name (SSID)
            TextField(
              controller: _ssidController,
              decoration: InputDecoration(
                labelText: "Wi-Fi Name (SSID)",
                prefixIcon: const Icon(Icons.wifi_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Wi-Fi Password
            TextField(
              controller: _passController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Wi-Fi Password",
                prefixIcon: const Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 40),
            
            // Update Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton(
                onPressed: _isLoading ? null : _saveWifi,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("UPDATE WIFI DETAILS", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
