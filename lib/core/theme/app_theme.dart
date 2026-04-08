import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryOrange = Colors.deepOrange;
  static const Color scaffoldBg = Color(0xFFF8F9FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        primary: primaryOrange,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      
      // GoogleFonts: Mukta फन्ट लागू गरिएको छ (नेपालीका लागि उत्कृष्ट)
      textTheme: GoogleFonts.muktaTextTheme(),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      // --- FIX: CardTheme Error Solution ---
      // 'CardTheme' लाई 'CardThemeData' मा बदलियो
      cardTheme: CardThemeData( 
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // --- FIX: DialogTheme Error Solution ---
      // 'DialogTheme' लाई 'DialogThemeData' मा बदलियो
      dialogTheme: DialogThemeData( 
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: GoogleFonts.mukta(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Button Themes
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.mukta(fontWeight: FontWeight.w600),
        ),
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor: primaryOrange.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.mukta(fontWeight: FontWeight.bold, color: primaryOrange);
          }
          return GoogleFonts.mukta();
        }),
      ),
    );
  }
}
