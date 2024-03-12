// import 'dart:html';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persona/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications{

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();//added start

  //on tap on any notif

  static void onNotificationTap(
    NotificationResponse notificationResponse
  ){
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future init() async{
    await _requestNotificationPermission();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/logo');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification:(id, title, body, payload) => null);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
            defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:(details) => null,
        );
      }

  static Future _requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denied or show an explanation dialog
      print('Notification permission denied');
    }
  }

  static Future showSimpleNotification({
    required String title, 
    required String body,
    required String payload,
  })async{
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails,
        payload: payload);
  }


  //to show periodic notification at regular interval

  static Future showPeriodicNotification({
    required String title, 
    required String body,
    required String payload,
  })async{
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      1, title, body, RepeatInterval.everyMinute
      , notificationDetails
    );
  }

static Future showSchedulledNotification({
    required String title, 
    required String body,
    required String payload,
    required DateTime time,
  })async{
    int id_notif = (time.day+time.month+time.hour+time.minute);
    print(id_notif);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
    tz.TZDateTime dateTime = tz.TZDateTime.from(time, tz.getLocation('Asia/Jakarta'));
    print(dateTime);
    // var localTime = tz.local;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(id_notif, title, body, dateTime, notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    // print(tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)));
  }


  static tz.TZDateTime get scheduledDate {
    // Set the scheduled date and time for the notification
  

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
    );

    return scheduledDate.add(const Duration(minutes: 1)); // Example: schedule for the next day
  }
  //close a specific channel notification
  static Future cancel(int id)async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  //close all the notif avail
  static Future cancelAll()async{
    await _flutterLocalNotificationsPlugin.cancelAll();
  }


}