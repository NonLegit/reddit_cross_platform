// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:post/notification/screens/navigate_to_correct_screen.dart';

// class HelperNotification{
// static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
//    var initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//        // var iOSInitialize = IOSInitializationSettings();
//     var initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings ,onDidReceiveNotificationResponse:onDidReceiveNotificationResponse );
// }


// void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       print('notification payload: $payload');
//     }
//     Navigator.of(context).pushNamed(NavigateToCorrectScreen.routeName);
// }
// }