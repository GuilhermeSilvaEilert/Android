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
    // TODO(Lyokone): Remove when FlutterFire CLI updated
      case TargetPlatform.windows:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDdRD0CGGqwvEiVC5_-i5luvfah0yD2yQE",
      authDomain: "cardapiovirtual-d082b.firebaseapp.com",
      databaseURL: "https://cardapiovirtual-d082b-default-rtdb.firebaseio.com",
      projectId: "cardapiovirtual-d082b",
      storageBucket: "cardapiovirtual-d082b.appspot.com",
      messagingSenderId: "147183865053",
      appId: "1:147183865053:web:def56489d7708c8f2f5f34",
      measurementId: "G-JGMBTM6V45"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdRjCVZlhrq72RuEklEyyxYlBRCYhI2Sw',
    appId: '1:406099696497:android:0d4ed619c031c0ac3574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
    'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:406099696497:ios:acd9c8e17b5e620e3574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
    'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
    '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
    iosClientId:
    '406099696497-taeapvle10rf355ljcvq5dt134mkghmp.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.tests',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:406099696497:ios:acd9c8e17b5e620e3574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
    'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
    '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
    iosClientId:
    '406099696497-taeapvle10rf355ljcvq5dt134mkghmp.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.tests',
  );
}