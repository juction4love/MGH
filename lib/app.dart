import 'package:flutter/material.dart';
import 'package:mgh/core/theme/app_theme.dart';
import 'package:mgh/main_screen.dart';

class MuktinathGuestHouseApp extends StatelessWidget {
  const MuktinathGuestHouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muktinath Guest House',
      theme: AppTheme.lightTheme, // app_theme.dart बाट आउनेछ
      home: const MainScreen(),
    );
  }
}
