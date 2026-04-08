import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mgh/features/news/data/models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  final List<NewsHeadline> _headlines = [];
  bool _isLoading = false;

  List<NewsHeadline> get headlines => _headlines;
  bool get isLoading => _isLoading;

  /// १. मुख्य खबरहरू तान्ने (Fetch News from Multiple Sources)
  /// यसले अनलाइनखबर र रातोपाटी जस्ता ठूला पत्रिकाहरूका RSS फिडहरू तान्छ।
  Future<void> fetchLatestHeadlines() async {
    _isLoading = true;
    notifyListeners();
    
    _headlines.clear();

    try {
      // अनलाइनखबर RSS (Example)
      final ohHeadlines = await _fetchFromRSS("Onlinekhabar", "https://www.onlinekhabar.com/feed");
      _headlines.addAll(ohHeadlines);

      // रातोपाटी RSS (Example)
      final rpHeadlines = await _fetchFromRSS("Ratopati", "https://ratopati.com/feed");
      _headlines.addAll(rpHeadlines);

      // समय अनुसार क्रमबद्ध गर्ने (Newest First)
      _headlines.sort((a, b) => b.time.compareTo(a.time));
    } catch (e) {
      debugPrint("News Fetch Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// २. RSS XML डाटा पार्स गर्ने (Simple Manual XML Extraction to avoid XML Package conflict)
  Future<List<NewsHeadline>> _fetchFromRSS(String source, String url) async {
    final List<NewsHeadline> extracted = [];
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final String xml = response.body;

        // <item> ट्यागको विवरण निकाल्ने
        final List<String> items = xml.split('<item>').skip(1).toList();

        for (var itemXml in items) {
          if (extracted.length >= 5) break; // हरेक पत्रिकाबाट ५ वटा समाचार मात्र

          final String title = _extractField(itemXml, 'title');
          final String link = _extractField(itemXml, 'link');
          
          if (title.isNotEmpty) {
            extracted.add(NewsHeadline(
              source: source,
              title: title.replaceAll('<![CDATA[', '').replaceAll(']]>', ''),
              link: link,
              time: DateTime.now(), // RSS को <pubDate> लाई पछि पार्स गर्न सकिन्छ
            ));
          }
        }
      }
    } catch (e) {
       debugPrint("RSS Parse Error ($source): $e");
    }
    return extracted;
  }

  String _extractField(String xml, String field) {
    try {
      final start = xml.indexOf('<$field>') + field.length + 2;
      final end = xml.indexOf('</$field>');
      if (start < end) {
        return xml.substring(start, end).trim();
      }
    } catch (_) {}
    return "";
  }
}
