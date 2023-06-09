// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjmgf8bUrc_3HN2Gkkt2WXPe_Kt8TLPZg',
    appId: '1:751352538134:web:3869c9aa9e7c28ee10c137',
    messagingSenderId: '751352538134',
    projectId: 'swap-dfbde',
    authDomain: 'swap-dfbde.firebaseapp.com',
    storageBucket: 'swap-dfbde.appspot.com',
    measurementId: 'G-EFHKJZ3M30',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCabUt5a1hRvNAyn9wlNtsHYG2oHi0CUpA',
    appId: '1:751352538134:android:735ec7ea30a65de810c137',
    messagingSenderId: '751352538134',
    projectId: 'swap-dfbde',
    storageBucket: 'swap-dfbde.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTIIONYfWem-F-pqhpDqWG8Krck0inpsg',
    appId: '1:751352538134:ios:3127e0577454476410c137',
    messagingSenderId: '751352538134',
    projectId: 'swap-dfbde',
    storageBucket: 'swap-dfbde.appspot.com',
    iosClientId:
        '751352538134-ds6gn6bhltmtnfkrhfll2edi1uuhbman.apps.googleusercontent.com',
    iosBundleId: 'com.example.swap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTIIONYfWem-F-pqhpDqWG8Krck0inpsg',
    appId: '1:751352538134:ios:3127e0577454476410c137',
    messagingSenderId: '751352538134',
    projectId: 'swap-dfbde',
    storageBucket: 'swap-dfbde.appspot.com',
    iosClientId:
        '751352538134-ds6gn6bhltmtnfkrhfll2edi1uuhbman.apps.googleusercontent.com',
    iosBundleId: 'com.example.swap',
  );
}
