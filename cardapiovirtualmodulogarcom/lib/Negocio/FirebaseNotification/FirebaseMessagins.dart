import 'package:cardapiovirtualmodulogarcom/Negocio/FirebaseNotification/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagins{

 final NotificationService _notificationService;
 FirebaseMessagins(

     this._notificationService

 );

 Future<void> initialize() async{
   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
     badge: true,
     alert: true,
     sound: true,
   );
   getDeviceFirebaseToken();
   _onMessage();

 }

 getDeviceFirebaseToken() async{
   final token = await FirebaseMessaging.instance.getToken();
   debugPrint('=============');
   debugPrint('Token: $token');
   debugPrint('=============');
 }

 _onMessage() async {
   FirebaseMessaging.onMessage.listen((message) {
     RemoteNotification?  notification =  message.notification;
     AndroidNotification? android = message.notification?.android;

     if(notification != null && android != null){
       _notificationService.showNotification(
         CustomNotification(
             id: android.hashCode,
             title: notification.title,
             body: notification.body,
             payload: '/home'
         )
       );
     }
   });
 }
}