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
    apiKey: 'AIzaSyAhzcaAOWeByx06Zg3OVG1gKo-_2hEsq7A',
    appId: '1:688477875278:web:00d844603c5a44af02671f',
    messagingSenderId: '688477875278',
    projectId: 'hospital-car-af591',
    authDomain: 'hospital-car-af591.firebaseapp.com',
    storageBucket: 'hospital-car-af591.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfHENvLJgzcUaadDCUATiGlrOUAOfuMXU',
    appId: '1:688477875278:android:d17bc9cb547c6e7802671f',
    messagingSenderId: '688477875278',
    projectId: 'hospital-car-af591',
    storageBucket: 'hospital-car-af591.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHEj7fJRdGhx3QO1m5wjsbxuCb6shW_MM',
    appId: '1:688477875278:ios:1f8b8071c675bc3302671f',
    messagingSenderId: '688477875278',
    projectId: 'hospital-car-af591',
    storageBucket: 'hospital-car-af591.appspot.com',
    iosBundleId: 'com.example.hospitalCar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHEj7fJRdGhx3QO1m5wjsbxuCb6shW_MM',
    appId: '1:688477875278:ios:1f8b8071c675bc3302671f',
    messagingSenderId: '688477875278',
    projectId: 'hospital-car-af591',
    storageBucket: 'hospital-car-af591.appspot.com',
    iosBundleId: 'com.example.hospitalCar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhzcaAOWeByx06Zg3OVG1gKo-_2hEsq7A',
    appId: '1:688477875278:web:afde90df9dad96f502671f',
    messagingSenderId: '688477875278',
    projectId: 'hospital-car-af591',
    authDomain: 'hospital-car-af591.firebaseapp.com',
    storageBucket: 'hospital-car-af591.appspot.com',
  );
}
