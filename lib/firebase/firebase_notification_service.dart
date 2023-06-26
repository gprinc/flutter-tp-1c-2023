import 'dart:io';

import 'package:dam_1c_2023/firebase/firebase_notification_provider.dart';
import 'package:dam_1c_2023/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging => FirebaseNotificationService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseNotificationService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseNotificationService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await FirebaseNotificationService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async => await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin get localNotificationsPlugin => FirebaseNotificationService._localNotificationsPlugin;
  
  static Future<void> initializeLocalNotifications() async {

    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? token = await firebaseMessaging.getToken();
    print(token);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    const InitializationSettings _initSettings = InitializationSettings(
      android: AndroidInitializationSettings("app_icon"),
    );
    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseNotificationService.localNotificationsPlugin.initialize(
      _initSettings, 
      onDidReceiveNotificationResponse: FCMProvider.onTapNotification
    );
    /// need this for ios foregournd notification
    await FirebaseNotificationService.firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  
  static NotificationDetails platformChannelSpecifics = const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel", 
      "High Importance Notifications", 
      priority: Priority.max, 
      importance: Importance.max,
    ),
  );
  
  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // if this is available when Platform.isIOS, you'll receive the notification twice 
        await FirebaseNotificationService._localNotificationsPlugin.show(
          0, message.notification!.title, message.notification!.body, FirebaseNotificationService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }

}