import 'package:cardapiovirtualmodulogarcom/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


class CustomNotification{
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotificationService{

  late  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService(){
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setUpTimezone();
    await _initializeNotifications();
  }

  Future<void> _setUpTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload){
    if(payload != null && payload.isNotEmpty){
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(payload);
    }
  }
  
  showNotification(CustomNotification notification){
    androidDetails = const AndroidNotificationDetails(
        'lembretes_notifications_x',
        'Lembretes',
      channelDescription: 'Canal lembretes',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id!,
      notification.title,
      notification.body,
      NotificationDetails(
       android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp){
      _onSelectNotification(details.payload);
    }
  }

}