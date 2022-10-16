// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _notification.initialize(settings);

    tz.initializeTimeZones();
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  static Future setNotification({
    required DateTime scheduledDate,
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future cancelNotification({String? name}) async {
    final pendingNotifications =
        await _notification.pendingNotificationRequests();

    for (final notification in pendingNotifications) {
      if (notification.title == name) {
        await _notification.cancel(notification.id);
        return;
      }
    }
  }

  static Future<List<String?>> getPendingNotification() async {
    final pendingNotifications =
        await _notification.pendingNotificationRequests();

    return pendingNotifications.map((notif) => notif.title).toList();
  }
}
