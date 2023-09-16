import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

void initFirebaseMessaging() {
  firebaseMessaging.getToken().then((token) {
    log('FCM Token: $token');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle when the app is in the foreground and receives a notification
    log('FCM Message: ${message.notification?.body}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle when the user taps the notification while the app is in the background
    log('FCM Message opened app: ${message.notification?.body}');
  });
}
