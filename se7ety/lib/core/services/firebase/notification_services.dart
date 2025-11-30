import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/firebase_options.dart';

class NotificationServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    // 1) request permission
    await _firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    // 2) handle token
    String? token;

    if (Platform.isAndroid) {
      token = await _firebaseMessaging.getToken();
    } else {
      token = await _firebaseMessaging.getAPNSToken();
    }

    if (token != null) {
      // call api to save token
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // call api to update token
    });

    // 3) handle messages (foreground/ background / terminated)

    // ------- handle foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //! we have to display the notification using flutter_local_notifications plugin
      if (message.notification != null) {
        _showNotification(message);
      }
      // TODO: Handle redirect to specific screen based on message data
      if (message.notification != null) {
        _handleNavigation(message);
      }
    });

    // -------handle background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // ------- handle when app is terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // TODO: Handle redirect to specific screen based on message data
      if (message.notification != null) {
        _handleNavigation(message);
      }
    });

    // ------- handle when app is terminate
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      // TODO: Handle redirect to specific screen based on message data
      if (message?.notification != null) {
        _handleNavigation(message!);
      }
    });

    // 4) configure local notifications
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        );
    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'default_channel_id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      notificationDetails,
      payload: message.data.toString(),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void _handleNavigation(RemoteMessage message) {
  if (message.data['source'] == 'search') {
    pushToBase(
      navigatorKey.currentContext!,
      Routes.homeSearch,
      extra: message.data['query'],
    );
  }
}
