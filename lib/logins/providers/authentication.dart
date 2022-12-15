// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../main.dart';
//import '../../models/push_notification_model.dart';
import '../../notification/models/notification_class_model.dart';
import '../../notification/provider/notification_provider.dart';
import './notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
NotificationProvider provider = NotificationProvider();
@pragma('vm:entry-point')
NotificationModel notificationModel = NotificationModel();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print('hidojsljfkbgdvdbhnjkjhgvfcvgbdsfghgfdfffghjhdfrghhnjmk');
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  //print('hidojsljfkbgdvdbhnjkjhgvfcvgbhnjmk');
  await setupFlutterNotifications();
  print('Handling a background message ${message.messageId}');
  RemoteNotification? notification = message.notification;
  notificationModel =
      NotificationModel.fromJson(json.decode(message.data['val']));
  //provider.incrementCounter();
  print('returned from counter in background');
  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      returnCorrectText(notificationModel.type, notificationModel.requiredName,
          notificationModel.followeruserName),
      //notificationModel.type,
      //notificationModel.description,

      returnCorrectDescription(notificationModel.type,
          notificationModel.description, notificationModel.requiredName),
      NotificationDetails(
          android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        color: Colors.blue,
        playSound: true,
        // icon: ('assets/images/reddit.png'),
      )));
}

bool isFlutterLocalNotificationsInitialized = false;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    print('settings doneeeeeeeeeee');
    return;
  }
  // print('Print the channel $channel');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

class Auth with ChangeNotifier {
  final url = dotenv.env['API'] as String;
  bool error = false;
  String errorMessage = '';
  String token = '';
  DateTime expiresIn = DateTime.now();
  bool alreadyAuthed = false;
  Future<void> alreadyAuth() async {
    final prefs = await SharedPreferences.getInstance();
    print(DateTime.parse(prefs.getString('expiresIn') as String)
        .isBefore(DateTime.now()));
    // alreadyAuthed = prefs.getString('token') != null;
  }

  Future<void> sinUp(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/signup'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      error = response.statusCode != 201;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      } else {
        token = json.decode(response.body)['token'];
        expiresIn =
            DateTime.parse(json.decode(response.body)['expiresIn'].toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('expiresIn', expiresIn.toString());
        await prefs.setString('userName', query['userName'] as String);
        await Firebase.initializeApp();
        final notificationToken = prefs.get('notificationToken');
        await NotificationToken.sendTokenToDatabase(notificationToken);
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
    print(token);
  }

  Future<void> login(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/login'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      print(response);
      error = response.statusCode != 200;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      } else {
        token = json.decode(response.body)['token'];

        DateTime.parse(json.decode(response.body)['expiresIn'].toString());
        expiresIn =
            DateTime.parse(json.decode(response.body)['expiresIn'].toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('expiresIn', expiresIn.toString());
        await prefs.setString('userName', query['userName'] as String);
        await Firebase.initializeApp();
        final notificationToken = prefs.get('notificationToken');
        await NotificationToken.sendTokenToDatabase(notificationToken);
        await NotificationToken.refreshToken();
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
    print(token);
  }

  Future<bool> availableUserName(userName) async {
    http.Response? response = null;
    try {
      response = await http.get(
          Uri.parse(url + '/users/username_available?userName=' + userName),
          headers: {
            'Accept': 'application/json',
          });
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
    // print(response!.body);
    return jsonDecode(response!.body)['available'];
  }

  Future<bool> changeGender(String Gender) async {
    http.Response? response = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') as String;
      print(token);

      /// change geneder need cookies
      response = await http.patch(Uri.parse(url + '/users/me/prefs'),
          body: json.encode({"gender": Gender}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') as String;
      print(token);

      /// change geneder need cookies
      response = await http.get(Uri.parse(url + '/users/me/prefs'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      });
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
    return response!.statusCode == 200;
  }

  Future<void> forgetUserName(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/forgot_username'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      error = response.statusCode != 204;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> forgetPassword(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/forgot_username'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      error = response.statusCode != 204;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
  }
}
