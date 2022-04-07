import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  BuildContext? _context;

  //initializing notification
  Future<FlutterLocalNotificationsPlugin> initNotification(
      BuildContext context) async {
    _context = context;

    var initSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initSettingsIOS = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotiPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotiPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotiPlugin;
  }

//remove Notification
  Future removeNotification(int notifyId,
      FlutterLocalNotificationsPlugin flutterLocalNotiPlugin) async {
    try {
      return await flutterLocalNotiPlugin.cancel(notifyId);
    } catch (e) {
      return null;
    }
  }

  //show Notification
  Future showNotification(String title, String description, int time, int id,
      FlutterLocalNotificationsPlugin flutterLocalNotiPlugin) async {
    await flutterLocalNotiPlugin.zonedSchedule(
        id.toInt(),
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'medicines_id',
          'medicines',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.cyanAccent,
          sound: RawResourceAndroidNotificationSound('take_your_medicine_long'),
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //on select notification
  Future onSelectNotification(String? data) async {
    showDialog(
      context: _context!,
      builder: (_) {
        return AlertDialog(
          title: const Text("Take Medicines"),
          content: Text("Payload : $data"),
        );
      },
    );
  }
}
