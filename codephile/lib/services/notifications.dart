import 'package:codephile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

Future<void> setNotification({
  String name,
  DateTime startTime,
  String platform,
  Duration offset
}) async {
  var scheduledNotificationDateTime = startTime
      .subtract(offset);
  // var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails('1',
      'Contest Alerts', 'Alerts for Contests marked with \'Notify Me\' option',
      icon: 'secondary_icon',
      // sound: 'slow_spring_board',
      // largeIcon: 'sample_large_icon',
      // largeIconBitmapSource: BitmapSource.Drawable,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500);
  var iOSPlatformChannelSpecifics =
      IOSNotificationDetails(sound: 'slow_spring_board.aiff');
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  List pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  // print(pendingNotifications[0].toString());
  await flutterLocalNotificationsPlugin.schedule(
      pendingNotifications.length,
      name,
      'Contest Starts at $startTime',
      scheduledNotificationDateTime,
      // DateTime.now().add(Duration(seconds: 5)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true);
}

Future<void> removeNotification({String name}) async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  int index = pendingNotifications.indexWhere((notif) => notif.title == name);
  if (index == -1) return;
  await flutterLocalNotificationsPlugin.cancel(pendingNotifications[index].id);
}

Future<List<String>> getNotificationList() async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return pendingNotifications.map((val) => val.title).toList();
}

Future<int> getID({String name}) async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return pendingNotifications[
          pendingNotifications.indexWhere((notif) => notif.title == name)]
      .id;
}
