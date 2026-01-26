import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_page.dart';
import 'features/dining/presentation/dining_page.dart';
import 'features/guide/presentation/guide_page.dart';
import 'features/booking/presentation/room_detail_page.dart';

@pragma('vm:entry-point') 
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "daily_backup") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_backup', DateTime.now().toString());
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Background Backup
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  
  // Schedule 5 AM Backup
  DateTime now = DateTime.now();
  DateTime target = DateTime(now.year, now.month, now.day, 5, 0, 0);
  if (now.isAfter(target)) target = target.add(const Duration(days: 1));
  
  Workmanager().registerPeriodicTask(
    "backup_task", 
    "daily_backup",
    frequency: const Duration(hours: 24),
    initialDelay: target.difference(now),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
  );

  runApp(const MuktinathApp());
}

class MuktinathApp extends StatelessWidget {
  const MuktinathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muktinath Guesthouse',
      theme: AppTheme.lightTheme, // Light Theme Only
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _idx = 0;
  final String _phone = "9847634444";
  String _backupTime = "Loading...";

  final List<Widget> _pages = [const HomePage(), const DiningPage(), const GuidePage()];

  @override
  void initState() {
    super.initState();
    _checkBackup();
  }

  void _checkBackup() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _backupTime = prefs.getString('last_backup') ?? "Pending...");
  }

  void _call() async {
    final Uri launchUri = Uri(scheme: 'tel', path: _phone);
    if (!await launchUrl(launchUri)) debugPrint("Call failed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepOrange),
              accountName: const Text("Muktinath Guest"),
              accountEmail: const Text("Welcome!"),
              currentAccountPicture: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.deepOrange)),
            ),
            ListTile(leading: const Icon(Icons.bed), title: const Text("Book Room"), onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomDetailPage())); }),
            ListTile(leading: const Icon(Icons.phone), title: const Text("Call 9847634444"), onTap: () { Navigator.pop(context); _call(); }),
            const Divider(),
            ListTile(leading: const Icon(Icons.cloud_done, color: Colors.green), title: const Text("Auto Backup"), subtitle: Text("Last: $_backupTime")),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.info), 
              title: const Text("About App"), 
              onTap: () {
                Navigator.pop(context);
                showDialog(context: context, builder: (c) => AlertDialog(
                  title: const Text("Developer Info"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.code, color: Colors.white)),
                      SizedBox(height: 10),
                      Text("Bimal", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Handle: juction4love", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 15),
                      Text("Version 1.0.0 Pro", style: TextStyle(fontSize: 12)),
                    ]
                  ),
                  actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("Close"))],
                ));
              }
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _pages[_idx],
      floatingActionButton: _idx == 0 ? FloatingActionButton.extended(
        onPressed: () {
          showDialog(context: context, builder: (c) => AlertDialog(
            title: const Text("Quick Book"),
            content: const Text("Call Front Desk?"),
            actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("No")), FilledButton(onPressed: () { Navigator.pop(c); _call(); }, child: const Text("Call"))],
          ));
        },
        label: const Text("Book Now"), icon: const Icon(Icons.call), backgroundColor: Colors.deepOrange,
      ) : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(icon: Icon(Icons.restaurant), label: "Menu"),
          NavigationDestination(icon: Icon(Icons.map), label: "Guide"),
        ],
      ),
    );
  }
}
