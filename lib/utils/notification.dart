import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

///TODO
class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await notificationDetails(),
          payload: payload);

  static Future scheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduledDaily(Time(23, 10, 00)), //UTC time
        await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  static Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId', 'channelName', 'channelDescription',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initSchedule = false}) async {
    tz.initializeTimeZones(); //This timezone default is on UTC
    var android = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher
    var iOS = IOSInitializationSettings();
    var settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    scheduledNotification(
        title: 'Absen Portal',
        body: "Sudahkan Anda Absen Portal Hari ini?",
        scheduledDate: _scheduledDaily(Time()));
  }
}
