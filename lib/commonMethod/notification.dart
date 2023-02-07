import 'dart:developer';
import 'package:doctor_on_call/commonMethod/storage_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// FIREBASE NOTIFICATION SETUP
  static Future<void> firebaseNotificationSetup() async {
    ///firebase initiallize
    await Firebase.initializeApp();

    ///local notification...
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    ///Get FCM Token..
    await getFcmToken();
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: "Teleport User",
    importance: Importance.high,
    playSound: true,
  );

  ///get fcm token
  static Future<String?> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      String? token = await firebaseMessaging.getToken().catchError((e) {
        log("=========fcm- Error ....:$e");
      });
      await PreferenceManager.setFcmToken(token!);
      log("=========fcm-token===>>  $token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    print('showMsgHandler...');
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
        }
      },
    );
  }

  /// handle notification when app in fore ground..
  static void getInitialMsg() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {});
  }

  ///show notification msg
  static void showMsg(
      RemoteNotification notification, Map<String, dynamic> time) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', //
              channelDescription: 'Teleport User', // title
              importance: Importance.high,
              icon: '@drawable/notification_icon',
              playSound: true,
              color: Color(0xffEAD256)),
        ));
  }

  ///call when click on notification
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }
}
