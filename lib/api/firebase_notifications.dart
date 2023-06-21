import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final notification = message.notification;
    final data = message.data;

    if (notification != null) {
      // Handle the notification message
      print('Title: ${notification.title}');
      print('Body: ${notification.body}');
    }

    if (data.isNotEmpty) {
      // Handle the data payload
      print('Payload: $data');

      // Extract necessary information from the payload
      final id = data['id'];

      if (id != null) {
        // Navigate to the 'selected-card' route with the given ID
        navigatorKey.currentState?.pushNamed('/selected-card/$id');
      }
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
