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
    apiKey: 'AIzaSyBU77STpXHO3C0UiXOIcI3jAN_nNEwvWC0',
    appId: '1:24351053801:web:6edf54fced8e5efa3d5d78',
    messagingSenderId: '24351053801',
    projectId: 'second-wisy-project',
    authDomain: 'second-wisy-project.firebaseapp.com',
    storageBucket: 'second-wisy-project.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH8wFUQhHBzgjYX-SFI8OVdMPIuAutltQ',
    appId: '1:24351053801:android:93a4ad6abf7a7e293d5d78',
    messagingSenderId: '24351053801',
    projectId: 'second-wisy-project',
    storageBucket: 'second-wisy-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxb2oewQoLhSuXHtpSa5ZtkkOSnZYzLcM',
    appId: '1:24351053801:ios:39329b476dbf88cf3d5d78',
    messagingSenderId: '24351053801',
    projectId: 'second-wisy-project',
    storageBucket: 'second-wisy-project.firebasestorage.app',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxb2oewQoLhSuXHtpSa5ZtkkOSnZYzLcM',
    appId: '1:24351053801:ios:39329b476dbf88cf3d5d78',
    messagingSenderId: '24351053801',
    projectId: 'second-wisy-project',
    storageBucket: 'second-wisy-project.firebasestorage.app',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBU77STpXHO3C0UiXOIcI3jAN_nNEwvWC0',
    appId: '1:24351053801:web:ca75b2bfc5bbcb993d5d78',
    messagingSenderId: '24351053801',
    projectId: 'second-wisy-project',
    authDomain: 'second-wisy-project.firebaseapp.com',
    storageBucket: 'second-wisy-project.firebasestorage.app',
  );

}