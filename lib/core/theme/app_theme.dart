import 'package:flutter/material.dart';

class AppTheme {
  // LIGHT THEME ONLY
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Cream Background
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    // Fixed: Removed cardTheme to avoid type errors.
    // Material 3 defaults will handle the look automatically.
  );
}
