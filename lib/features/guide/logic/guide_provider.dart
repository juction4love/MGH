import 'package:flutter/material.dart';

class GuideProvider extends ChangeNotifier {
  // चितवन भ्रमण सम्बन्धी डाटा यहाँ व्यवस्थापन गर्न सकिन्छ।
  // भविष्यमा API बाट मौसम वा ठाउँहरूको डाटा तान्न यसको प्रयोग हुनेछ।
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
