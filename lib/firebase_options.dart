import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('iOS not configured yet.');
      default:
        throw UnsupportedError('Unsupported platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCrw_ysEgUgV2XNw2-irimbJZx22u7PHME',
    authDomain: 'lockedin-f4401.firebaseapp.com',
    projectId: 'lockedin-f4401',
    storageBucket: 'lockedin-f4401.firebasestorage.app',
    messagingSenderId: '91792254653',
    appId: '1:91792254653:web:897d3af2a08b03c0f039d4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrw_ysEgUgV2XNw2-irimbJZx22u7PHME',
    appId: '1:91792254653:web:897d3af2a08b03c0f039d4',
    messagingSenderId: '91792254653',
    projectId: 'lockedin-f4401',
    storageBucket: 'lockedin-f4401.firebasestorage.app',
  );
}
