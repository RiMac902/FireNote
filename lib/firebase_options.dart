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
    apiKey: 'AIzaSyBgkycVPiyt_O1ywb3kRA9bP7brHlh1DDc',
    appId: '1:1021668883034:web:179171f15184c490fd7663',
    messagingSenderId: '1021668883034',
    projectId: 'bloc-firebase-71dff',
    authDomain: 'bloc-firebase-71dff.firebaseapp.com',
    storageBucket: 'bloc-firebase-71dff.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7o20G0cVsMhVQyaVreLz0l7_pJIciWXk',
    appId: '1:1021668883034:android:e5c1fb16c685902efd7663',
    messagingSenderId: '1021668883034',
    projectId: 'bloc-firebase-71dff',
    storageBucket: 'bloc-firebase-71dff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCotYJ8f0Ym3hP7xxGFKAavIKKVxeldoo',
    appId: '1:1021668883034:ios:00f49fd5303b03cefd7663',
    messagingSenderId: '1021668883034',
    projectId: 'bloc-firebase-71dff',
    storageBucket: 'bloc-firebase-71dff.appspot.com',
    androidClientId: '1021668883034-cobc2hrajlb3ritosetj94mktlbknfi4.apps.googleusercontent.com',
    iosClientId: '1021668883034-pb297n0vou8ntb8o494ul7lb2d3njon2.apps.googleusercontent.com',
    iosBundleId: 'com.example.cleanFirenote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCotYJ8f0Ym3hP7xxGFKAavIKKVxeldoo',
    appId: '1:1021668883034:ios:5e7d849b3041868afd7663',
    messagingSenderId: '1021668883034',
    projectId: 'bloc-firebase-71dff',
    storageBucket: 'bloc-firebase-71dff.appspot.com',
    androidClientId: '1021668883034-cobc2hrajlb3ritosetj94mktlbknfi4.apps.googleusercontent.com',
    iosClientId: '1021668883034-1mdj8ar44tkve2enb6a21q3an9t07gb1.apps.googleusercontent.com',
    iosBundleId: 'com.example.cleanFirenote.RunnerTests',
  );
}
