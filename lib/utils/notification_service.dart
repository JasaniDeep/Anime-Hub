// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _fln =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     // Init local notifications
//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosInit = DarwinInitializationSettings();
//     const InitializationSettings settings = InitializationSettings(
//       android: androidInit,
//       iOS: iosInit,
//     );

//     await _fln.initialize(settings);

//     // Request permission (iOS)
//     await FirebaseMessaging.instance.requestPermission();

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final notification = message.notification;
//       final android = message.notification?.android;
//       if (notification != null) {
//         _showLocalNotification(
//           notification.title ?? '',
//           notification.body ?? '',
//         );
//       }
//     });

//     // Handle background messages are handled by a top-level handler (see main.dart)
//   }


//   static Future<void> _showLocalNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           'aprelika_channel',
//           'Aprelika Notifications',
//           channelDescription: 'General notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//         );
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//     );
//     await _fln.show(0, title, body, details);
//   }
// }
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const AndroidInitializationSettings android =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings settings =
//         InitializationSettings(android: android);

//     await _plugin.initialize(settings);
//   }

//   static Future<void> show(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'news_channel',
//       'News Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(android: androidDetails);

//     await _plugin.show(
//       DateTime.now().millisecond,
//       title,
//       body,
//       details,
//     );
//   }

//    static Future<void> askPermission() async {
//     var status = await Permission.notification.status;

//     if (!status.isGranted) {
//       await Permission.notification.request();
//     }
//   }
// }
