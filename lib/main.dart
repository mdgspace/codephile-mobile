import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Necessary if you intend to initialize in `main`.
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase section
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging.onMessage.listen(
    (message) {
      final notification = message.notification;
      if (notification != null) {
        debugPrint(
            'title: ${notification.title} \t body: ${notification.body}');
      }
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      final notification = message.notification;
      if (notification != null) {
        debugPrint(
          'title: ${notification.title} \t body: ${notification.body}',
        );
      }
    },
  );

  runApp(const Codephile());
}

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
