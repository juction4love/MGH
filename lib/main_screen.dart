import 'package:flutter/material.dart';
import 'package:mgh/features/home/presentation/home_page.dart';
import 'package:mgh/features/dining/presentation/dining_page.dart';
import 'package:mgh/features/guide/presentation/guide_page.dart';
import 'package:mgh/features/profile/profile_page.dart';
import 'package:mgh/shared/widgets/floating_call_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const DiningPage(),
    const GuidePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed, // Ensure more than 3 items display correctly
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Dining'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Guide'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: const FloatingCallButton(),
    );
  }
}
