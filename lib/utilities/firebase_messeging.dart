// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';

void initFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle when the app is in the foreground and receives a notification
    print('FCM Message: ${message.notification?.body}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle when the user taps the notification while the app is in the background
    print('FCM Message opened app: ${message.notification?.body}');
  });
}
