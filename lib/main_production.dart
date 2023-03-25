import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'data/config/config.dart';
import 'data/constants/strings.dart';
import 'presentation/core/bloc_observer.dart';
import 'presentation/core/main_app.dart';

void main() {
  // Zone for Sentry
  runZonedGuarded(
    () async {
      // Necessary if you intend to initialize in an async function.
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      // Preserve native splash screen even after first frame is loaded.
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      _initOrientations();
      await _initFirebase();
      await _initSentry();
      await _initHive();
      final hydratedStorage = await _initHydratedBloc();

      // Zone for Hydrated Bloc and AppBlocObserver.
      HydratedBloc.storage = hydratedStorage;
      Bloc.observer = AppBlocObserver();
      runApp(await Codephile.run());
    },
    _onError,
  );
}

void _initOrientations() {
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging.onMessage.listen(
    (message) {
      final notification = message.notification;
      if (notification != null) {
        debugPrint(
          'title: ${notification.title} \t body: ${notification.body}',
        );
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
}

Future<void> _initSentry() async {
  await SentryFlutter.init(
    (SentryFlutterOptions options) {
      options
        ..dsn = Environment.sentryDSN
        ..tracesSampleRate = 1.0
        ..reportPackages = true
        ..debug = kDebugMode;
    },
  );
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(AppStrings.hiveBoxName);
}

Future<Storage> _initHydratedBloc() async {
  return HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationSupportDirectory(),
  );
}

void _onError(Object exception, StackTrace stacktrace) async {
  Sentry.captureException(exception, stackTrace: stacktrace);
}
