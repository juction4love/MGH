package com.muktinath.mgh

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // यसले सबै प्लगइनहरू (Workmanager, Notifications, Khalti) लाई 
        // Flutter Engine सँग सही तरिकाले दर्ता गर्छ।
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
    }
}