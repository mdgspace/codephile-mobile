import 'package:codephile/homescreen.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/login/login_screen.dart';
import 'package:intent/intent.dart' as intent;
import 'package:intent/action.dart' as action;
import 'package:intent/extra.dart' as extra;
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
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();
NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('logo');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print(message.toString());
    },
    onLaunch: (Map<String, dynamic> message) async {
      print(message.toString());
    },
    onResume: (Map<String, dynamic> message) async {
      print(message.toString());
    },
  );
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new ChooseHome(),
    );
  }
}

class ChooseHome extends StatefulWidget {
  @override
  ChooseHomeState createState() => new ChooseHomeState();
}

class ChooseHomeState extends State<ChooseHome> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    final RemoteConfig _remoteConfig = await RemoteConfig.instance;
    final int version = 3;
    final defaults = <String, int>{'version': version};
    await _remoteConfig.setDefaults(defaults);
    await _remoteConfig.fetch(expiration: Duration(seconds: 5));
    await _remoteConfig.activateFetched();
    final int minimunVersion = _remoteConfig.getInt('version');
    print('Minimum version:- ' + minimunVersion.toString());
    if (version < minimunVersion) {
      print("1");
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFF3F4F7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Text(
                    "Update Available",
                    textAlign: TextAlign.center,
                  ),
                ),
                contentPadding: EdgeInsets.all(0),
                content: Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Text(
                    "This version of the application has been depricated, please update your app through the Google PlayStore.",
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                      padding: EdgeInsets.all(15),
                      onPressed: () {
                        intent.Intent()
                          ..setAction(action.Action.ACTION_SHOW_APP_INFO)
                          ..putExtra(extra.Extra.EXTRA_PACKAGE_NAME,
                              "in.ac.iitr.mdg.codephile")
                          ..startActivity().catchError((e) => print(e));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        color: codephileMain,
                        child:
                            Text("Okay", style: TextStyle(color: Colors.white)),
                      ))
                ],
                actionsPadding: EdgeInsets.all(0),
              ));
    } else {
      if (_seen) {
        String token = prefs.getString('token');
        String uid = prefs.getString('uid');
        if (token != null && uid != null) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => HomePage(token: token, userId: uid)));
        } else {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } else {
        prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => OnBoardingScreen()));
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
    return new Scaffold(
      body: new Center(
        child: new Text(""),
      ),
    );
  }
}
