import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'data/config/config.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      // Necessary if you intend to initialize in an async function.
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

      // Sentry section
      await SentryFlutter.init(
        (SentryFlutterOptions options) {
          options
            ..dsn = Environment.sentryDSN
            ..tracesSampleRate = 1.0
            ..reportPackages = true
            ..debug = kDebugMode;
        },
      );

      runApp(const Codephile());
    },
    (Object exception, StackTrace stack) async => Sentry.captureException(
      exception,
      stackTrace: stack,
    ),
  );
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
