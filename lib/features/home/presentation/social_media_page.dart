import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// १. सोसल मिडिया पेज (Social Media WebView Integration)
/// यसले मुक्तीनाथ गेष्टहाउसको फेसबुक वा टिकटक एकाउन्ट एपभित्रै लोड गर्छ।
class SocialMediaPage extends StatefulWidget {
  final String url;
  final String title;

  const SocialMediaPage({super.key, required this.url, required this.title});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Error: $error");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
        backgroundColor: widget.title.toLowerCase().contains("facebook") 
            ? const Color(0xFF1877F2) 
            : Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.teal)),
        ],
      ),
    );
  }
}
