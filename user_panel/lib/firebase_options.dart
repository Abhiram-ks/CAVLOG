// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCoVWdl91AGCIV3-GTV1fgAuXKkA0ssxug',
    appId: '1:76576135686:web:2b501083bbb141adb10187',
    messagingSenderId: '76576135686',
    projectId: 'cav-log',
    authDomain: 'cav-log.firebaseapp.com',
    storageBucket: 'cav-log.firebasestorage.app',
    measurementId: 'G-XTG3YQW9WX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVlTisIpz_RpkrLcpAIvwaKbwv6Ed3fp4',
    appId: '1:76576135686:android:cd7e647bad2f8c15b10187',
    messagingSenderId: '76576135686',
    projectId: 'cav-log',
    storageBucket: 'cav-log.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAedxAyEgRkuJ9X4yi6ukqpvSmHIXmqdlE',
    appId: '1:76576135686:ios:34937302287b6843b10187',
    messagingSenderId: '76576135686',
    projectId: 'cav-log',
    storageBucket: 'cav-log.firebasestorage.app',
    iosClientId: '76576135686-ugntsp1k95qap5f6mc1huiog5guhdtqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.userPanel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAedxAyEgRkuJ9X4yi6ukqpvSmHIXmqdlE',
    appId: '1:76576135686:ios:34937302287b6843b10187',
    messagingSenderId: '76576135686',
    projectId: 'cav-log',
    storageBucket: 'cav-log.firebasestorage.app',
    iosClientId: '76576135686-ugntsp1k95qap5f6mc1huiog5guhdtqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.userPanel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCoVWdl91AGCIV3-GTV1fgAuXKkA0ssxug',
    appId: '1:76576135686:web:2b501083bbb141adb10187',
    messagingSenderId: '76576135686',
    projectId: 'cav-log',
    authDomain: 'cav-log.firebaseapp.com',
    storageBucket: 'cav-log.firebasestorage.app',
    measurementId: 'G-XTG3YQW9WX',
  );

}