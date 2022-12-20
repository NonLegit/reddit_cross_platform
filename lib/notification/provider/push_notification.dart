// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:post/notification/screens/navigate_to_correct_screen.dart';

// import '../models/notification_class_model.dart';

// class PushNotification {
//   PushNotification(
//       {required this.channel,
//       required this.flutterLocalNotificationsPlugin,
//       required this.isFlutterLocalNotificationsInitialized});
//   AndroidNotificationChannel channel;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   bool isFlutterLocalNotificationsInitialized;
//   static NotificationModel? notificationModel;

//   initialization() {}

//   onMessageListener() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(message.data);
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       print(notification.hashCode);
//       if (message.data != null) {
//         print(message.data['val']);
//         // notificationModel =
//         //     NotificationModel.fromJson(json.decode(message.data['val']));
//         print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
//         print(channel.id);
//         print(channel.name);
//         print(channel.description);
//         print(message.data['val']);

//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             message.data['val'],
//             message.data['val'],
//             NotificationDetails(
//                 android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               color: Colors.blue,
//               playSound: true,
//             )));
//       }
//     });
//   }

//   onOpeningMessage(context) {
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (RemoteMessage message) async {
//         print('BYEEEEEEEEEEEEEEEEEEEEEEE');
//         print(message.data);
//         notificationModel =
//             NotificationModel.fromJson(json.decode(message.data['val']));
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android;
//         if (message.data != null) {
//           Navigator.of(context)
//               .popAndPushNamed(NavigateToCorrectScreen.routeName);
//         }
//       },
//     );
//   }
// }
