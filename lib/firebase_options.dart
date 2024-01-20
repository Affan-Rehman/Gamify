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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaWF7sg4KcjxB5WTa9vchR8eOpNIybfc0',
    appId: '1:252299321426:android:03daed2f8caa249de63f8b',
    messagingSenderId: '252299321426',
    projectId: 'gamify-2ad21',
    storageBucket: 'gamify-2ad21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASqQlq2bJHYhd-lho34ptt4RUkd_oIKnI',
    appId: '1:252299321426:ios:138f64a50da24829e63f8b',
    messagingSenderId: '252299321426',
    projectId: 'gamify-2ad21',
    storageBucket: 'gamify-2ad21.appspot.com',
    androidClientId: '252299321426-2gijcuhi4uitpqopombqh8bge6l9dt1g.apps.googleusercontent.com',
    iosClientId: '252299321426-klui1gc1pklro3899vpldecm4eisbug5.apps.googleusercontent.com',
    iosBundleId: 'com.affan.gamify',
  );
}
