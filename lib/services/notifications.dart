import 'package:codephile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> setNotification(
    {String? name,
    required DateTime startTime,
    String? platform,
    required Duration offset}) async {
  var scheduledNotificationDateTime =
      tz.TZDateTime.from(startTime.subtract(offset), tz.local);
  // var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 1));

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails('1',
      'Contest Alerts', 'Alerts for Contests marked with \'Notify Me\' option',
      icon: 'secondary_icon',
      // sound: 'slow_spring_board',
      // largeIcon: 'sample_large_icon',
      // largeIconBitmapSource: BitmapSource.Drawable,
      enableLights: true,
      color: Color.fromARGB(255, 255, 0, 0),
      ledColor: Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500);
  var iOSPlatformChannelSpecifics =
      const IOSNotificationDetails(sound: 'slow_spring_board.aiff');
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  List pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    pendingNotifications.length,
    name,
    'Contest Starts at ${DateFormat('hh:mm a dd, MMMM yyyy').format(startTime)}',
    scheduledNotificationDateTime,
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}

Future<void> removeNotification({String? name}) async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  int index = pendingNotifications.indexWhere((notif) => notif.title == name);
  if (index == -1) return;
  await flutterLocalNotificationsPlugin.cancel(pendingNotifications[index].id);
}

Future<List<String?>> getNotificationList() async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return pendingNotifications.map((val) => val.title).toList();
}

Future<int> getID({String? name}) async {
  List<PendingNotificationRequest> pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return pendingNotifications[
          pendingNotifications.indexWhere((notif) => notif.title == name)]
      .id;
}
