import 'package:android_intent_plus/android_intent.dart';
import 'package:codephile/homescreen.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:codephile/screens/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();
NotificationAppLaunchDetails? notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('logo');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  // Crashlytics.instance.enableInDevMode = true;
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      debugPrint('title: ${notification.title} \t body: ${notification.body}');
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      debugPrint('title: ${notification.title} \t body: ${notification.body}');
    }
  });
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChooseHome();
  }
}

class ChooseHome extends StatefulWidget {
  const ChooseHome({Key? key}) : super(key: key);

  @override
  ChooseHomeState createState() => ChooseHomeState();
}

class ChooseHomeState extends State<ChooseHome> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    final RemoteConfig _remoteConfig = RemoteConfig.instance;
    const int version = 10;
    final defaults = <String, int>{'version': version};
    await _remoteConfig.setDefaults(defaults);
    await _remoteConfig.fetch();
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await _remoteConfig.activate();
    final int minimunVersion = _remoteConfig.getInt('version');
    debugPrint('Minimum version:- ' + minimunVersion.toString());
    if (version < minimunVersion) {
      debugPrint("1");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: const Text(
              "Update Available",
              textAlign: TextAlign.center,
            ),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: const Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Text(
              "This version of the application has been depricated, please update your app through the Google PlayStore.",
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                const intent = AndroidIntent(
                  action: 'android.intent.action.SHOW_APP_INFO',
                  arguments: {
                    'android.intent.extra.PACKAGE_NAME':
                        'in.ac.iitr.mdg.codephile',
                  },
                );
                intent.launch().catchError((e) => debugPrint(e));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                color: codephileMain,
                child: const Text(
                  "Okay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
          actionsPadding: const EdgeInsets.all(0),
        ),
      );
    } else {
      if (_seen) {
        String? token = prefs.getString('token');
        String? uid = prefs.getString('uid');
        if (token != null && uid != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(token: token, userId: uid),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      } else {
        prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(""),
      ),
    );
  }
}
