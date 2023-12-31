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
    apiKey: 'AIzaSyAAM2aOqqAk-IPCd1njFguZK_utklDUTOI',
    appId: '1:885173831422:web:fcb4c5807d94d6e57807af',
    messagingSenderId: '885173831422',
    projectId: 'appcampeonatofut',
    authDomain: 'appcampeonatofut.firebaseapp.com',
    storageBucket: 'appcampeonatofut.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmTJIEX3f5Big-v4jh-3iS2bZel_fZMTg',
    appId: '1:885173831422:android:1acc9dfe389551087807af',
    messagingSenderId: '885173831422',
    projectId: 'appcampeonatofut',
    storageBucket: 'appcampeonatofut.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVn0TxD-Hm3Vf3lvBso20_63zaNbI7QX0',
    appId: '1:885173831422:ios:cc62854276503d6d7807af',
    messagingSenderId: '885173831422',
    projectId: 'appcampeonatofut',
    storageBucket: 'appcampeonatofut.appspot.com',
    iosClientId: '885173831422-4h3gjfdcd86srf3hi1b5de0sibffs42e.apps.googleusercontent.com',
    iosBundleId: 'com.example.ligafutApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVn0TxD-Hm3Vf3lvBso20_63zaNbI7QX0',
    appId: '1:885173831422:ios:423e0c0d33b33b177807af',
    messagingSenderId: '885173831422',
    projectId: 'appcampeonatofut',
    storageBucket: 'appcampeonatofut.appspot.com',
    iosClientId: '885173831422-mgj56j9q8s0785apjk1eagomi585ohd3.apps.googleusercontent.com',
    iosBundleId: 'com.example.ligafutApp.RunnerTests',
  );
}
