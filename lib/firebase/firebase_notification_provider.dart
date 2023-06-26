import 'dart:io';
import 'package:dam_1c_2023/firebase/firebase_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;
  static BuildContext? get contextProvider => FCMProvider._context;
  static void setContext(BuildContext context) => FCMProvider._context = context;

  static RemoteMessage? _lastRemoteMessage;
  static RemoteMessage? get lastRemoteMessage => FCMProvider._lastRemoteMessage;

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    if (FCMProvider._context == null || response?.payload == null) return;
    FCMProvider.backgroundHandler(FCMProvider.lastRemoteMessage);
  }
  
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        await FirebaseNotificationService.localNotificationsPlugin.show(
          0, message.notification!.title,
          message.notification!.body,
          FirebaseNotificationService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> backgroundHandler(RemoteMessage? message) async {
    if (message != null && _context != null && message.data['id'] != null) {
      if(message.data['type'] == 'noticias') {
        _context?.goNamed('selected-card', params: {'id': message.data['id']}); // cambiar por la ruta de la noticia
      } else if(message.data['type'] == 'voluntariados') {
        _context?.goNamed('selected-card', params: {'id': message.data['id']});
      }
    }
  }
}