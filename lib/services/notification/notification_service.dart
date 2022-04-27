import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    print('title: ${message.notification!.title ?? ""}');
    print('body: ${message.notification!.body ?? ""}');
  }
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String page = Routes.login;

  setPage(String value) => page = value;

  Future<void> initFCM() async {
    initLocalNotifications();
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.instance.getToken().then((value) => print(value));

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message while in the foreground!');
      print('Message data: ${message.data}');
      print('Page $page');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print('title: ${message.notification!.title ?? ""}');
        print('body: ${message.notification!.body ?? ""}');
        _showNotification(
            message.notification!.title!, message.notification!.body!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      if (page == Routes.home)
        GetIt.I.get<NavigationService>().navigateTo(Routes.login);
      else if (page == Routes.login)
        GetIt.I.get<NavigationService>().navigateTo(Routes.home);
    });
  }

  Future<String> getFCMToken() {
    try {
      return FirebaseMessaging.instance.getToken().then((value) {
        return value!;
      });
    } catch (e) {
      return Future.value("");
    }
  }

  Future<void> initLocalNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future _showNotification(String title, String message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
    );
  }
}
