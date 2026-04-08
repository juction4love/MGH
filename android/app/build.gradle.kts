import java.util.Properties

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
        localProperties.load(reader)
    }
}

val flutterRoot = localProperties.getProperty("flutter.sdk")
if (flutterRoot == null) {
    throw GradleException("Flutter SDK not found.")
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode")?.toInt() ?: 1
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.muktinath.mgh"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        // आधुनिक Java र Notification फिचरका लागि Desugaring इनेबल गरिएको
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.muktinath.mgh"
        // एन्ड्रोइड १४ र नयाँ लाइब्रेरीका लागि minSdk २३ उत्तम हुन्छ (Khalti 3.0.0+)
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 14
        versionName = "2.0.2"
    }

    signingConfigs {
        create("release") {
            keyAlias = "upload"
            keyPassword = "nitik123" 
            storeFile = file("upload-keystore.jks")
            storePassword = "nitik123"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            
            // White Screen समस्या समाधान गर्न यहाँ false बनाइएको छ
            // यसले Proguard ले कोड काट्ने डर हुँदैन
            isMinifyEnabled = false 
            isShrinkResources = false
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"), 
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // १. Modern Java Support (Desugaring)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // २. नयाँ Android 14 (SDK 34) का लागि Play Core लाइब्रेरीहरू
    // यसले "Broadcast Receiver" एरर र गुगल प्ले स्टोरको रिजेक्सन हटाउँछ
    implementation("com.google.android.play:feature-delivery:2.1.0")
    implementation("com.google.android.play:app-update:2.1.0")
    implementation("com.google.android.play:review:2.0.1")
}
