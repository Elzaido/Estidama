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
    apiKey: 'AIzaSyCGRkm3bHJi2WJ6pYWo-m8RAm9aSzJJyeM',
    appId: '1:315620808998:web:756e8d00f705882d0989e7',
    messagingSenderId: '315620808998',
    projectId: 'estidama-cb513',
    authDomain: 'estidama-cb513.firebaseapp.com',
    storageBucket: 'estidama-cb513.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX5dChaJLqLMN5L20hJvL15HM9VKy2ATA',
    appId: '1:315620808998:android:835093f293a590e40989e7',
    messagingSenderId: '315620808998',
    projectId: 'estidama-cb513',
    storageBucket: 'estidama-cb513.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzfP6PyNitUVTynCXQmXlGE3BfveNvpaw',
    appId: '1:315620808998:ios:2c87c015dc8c17220989e7',
    messagingSenderId: '315620808998',
    projectId: 'estidama-cb513',
    storageBucket: 'estidama-cb513.appspot.com',
    iosBundleId: 'com.example.madenati',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzfP6PyNitUVTynCXQmXlGE3BfveNvpaw',
    appId: '1:315620808998:ios:8e656884d3a3b5610989e7',
    messagingSenderId: '315620808998',
    projectId: 'estidama-cb513',
    storageBucket: 'estidama-cb513.appspot.com',
    iosBundleId: 'com.example.madenati.RunnerTests',
  );
}
