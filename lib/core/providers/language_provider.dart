import 'package:flutter/material.dart';

/// पाहुनालाई सजिलो होस् भनेर सबै बटन र जानकारीहरू नेपालीमा राखिएको छ।
class LanguageProvider extends ChangeNotifier {
  // सधैँ नेपाली भाषा (Nepali) मात्र प्रयोग गर्ने
  final Locale _currentLocale = const Locale('ne', ''); 
  
  Locale get currentLocale => _currentLocale;

  // एपभरि नेपाली मात्र लागू भएको जनाउन
  bool get isNepali => true;
}
