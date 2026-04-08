#-------------------------------------------------------------------------
# MGH App - FINAL REFINED PROGUARD RULES (Android 14 / SDK 34 Compatible)
#-------------------------------------------------------------------------

# १. Khalti SDK Rules
# भुक्तानी प्रक्रियामा अवरोध नआओस् भन्नका लागि खल्तीका क्लासहरू सुरक्षित राखिएको
-keep class com.khalti.** { *; }
-dontwarn com.khalti.**

# २. WebView/WebKit Rules
# न्युज पोर्टल र सोसल मिडिया लिंकहरू एप भित्रै खोल्नका लागि अनिवार्य
-keep class android.webkit.** { *; }
-keep interface android.webkit.** { *; }
-dontwarn android.webkit.**

# ३. Google Play Core Split Libraries (Essential for Android 14)
# प्ले स्टोरको भर्सन ३४ को चेतावनी हटाउन नयाँ लाइब्रेरीका क्लासहरू सुरक्षित गरिएको
-keep class com.google.android.play.core.common.** { *; }
-keep class com.google.android.play.core.appupdate.** { *; }
-keep class com.google.android.play.core.review.** { *; }
-keep class com.google.android.play.core.install.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.play.core.assetpacks.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.**

# ४. Flutter Core & Embedding Rules
# फ्लटरको आन्तरिक कार्यप्रणाली र प्लगइनहरूलाई सुरक्षित राख्न
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.editing.** { *; }
-keep class io.flutter.plugin.platform.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.plugins.** { *; }

# ५. Workmanager Rules
# ब्याकग्राउन्डमा समाचार अपडेट (News Fetching) गर्ने काम सुचारु राख्न
-keep class dev.fluttercommunity.workmanager.** { *; }
-dontwarn dev.fluttercommunity.workmanager.**

# ६. Local Notifications
# सूचनाहरू (Notifications) सही समयमा देखाउनका लागि
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# ७. Network & Optimization Rules (Http/OkHttp)
# इन्टरनेटबाट डेटा तान्न प्रयोग हुने लाइब्रेरीहरूका लागि
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-ignorewarnings

# ८. Final Cleanup
# अनावश्यक नोट र चेतावनीहरूलाई बिल्ड लगबाट हटाउन
-dontnote com.google.android.play.core.**
-dontnote io.flutter.embedding.**