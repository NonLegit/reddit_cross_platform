import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post/logins/screens/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../main.dart';
import '../../notification/models/notification_class_model.dart';
import '../../notification/provider/notification_provider.dart';
import '../../shared/constants.dart';
import './notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import '../../widgets/handle_error.dart';

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
  ///the base URL of the backend server
  final url = dotenv.env['API'] as String;

  /// Whether ther is error in the calling or not
  bool error = false;

  ///the error message when there is an error
  String errorMessage = '';

  /// the token saved in login and sign up
  String token = '';

  /// the expire time of the token
  DateTime expiresIn = DateTime.now();

  /// Whether the user is already aluthed
  bool alreadyAuthed = false;

  ///check if the user is already Auth or not
  ///
  ///look in the shared prefrence and check
  ///if ther is token already saved or not
  ///if the token saved then check on its expire date
  ///if this isnot expired then enter the user
  Future<bool> alreadyAuth() async {
    //Input : none
    //Output: return whether the user Auth or not
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null &&
        prefs.getString('expiresIn') != null) {
      ///
      DateTime timeNow = DateTime.now();
      DateTime timeExpire =
          DateTime.parse(prefs.getString('expiresIn') as String);
      if (timeNow.isBefore(timeExpire)) {
        alreadyAuthed = true;

        /// call refresh token
      } else {
        alreadyAuthed = false;
      }
    }
    return alreadyAuthed;
  }

  ///log out the user and unAuth him
  ///
  ///delete the token and its expire date from the prfrence
  ///then go to the login
  Future<void> logOut(context) async {
    ///Input :
    /// the Build context of the calling screen\
    ///Output :none

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('expiresIn');
      Navigator.of(context).pushNamedAndRemoveUntil(
          Login.routeName,
          arguments: 'logout',
          (Route<dynamic> route) => false);

      notifyListeners();
    } on DioError catch (e) {
      error = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (eror) {
      error = true;
      errorMessage = eror.toString();
      HandleError.handleError(eror.toString(), context);
    }
  }

  ///sig up the user and Authenticate him
  ///
  ///take the data from sign up screen and send it by API to the server
  ///if sign uo done successfuly , then save the token and its expire date
  ///and prepare the shered prefrence by puting some intiall data to it
  Future<void> sinUp(Map<String, String> query) async {
    ///Input :
    /// query: the data of the user we want to sign him up
    ///Output :none
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
         await Firebase.initializeApp(options: FirebaseOptions(
          apiKey: Constants.apiKey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId));
          //Get token from fire base and send it to backend 
         final notificationToken = prefs.get('notificationToken');
         await NotificationToken.sendTokenToDatabase(notificationToken);
        preparePrefs();
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
  }

  ///log in the user and Authenticate him
  ///
  ///take the data from log in screen and send it by API to the server
  ///if sign uo done successfuly , then save the token and its expire date
  ///and prepare the shered prefrence by puting some intiall data to it

  Future<void> login(Map<String, String> query) async {
    ///Input :
    /// query: the data of the user we want to sign him up
    ///Output :none

    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/login'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
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
         await Firebase.initializeApp(options: FirebaseOptions(
          apiKey: Constants.apiKey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId));
        //Get token from fire base and send it to backend 
        await NotificationToken.getTokenOfNotification();
        final notificationToken = prefs.get('notificationToken');
         await NotificationToken.sendTokenToDatabase(notificationToken);
        preparePrefs();
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
  }

  ///prepare the prefrense by set default values to it
  ///
  ///function used when Authenticate the user
  ///to put default value for some data like(sort home posts - isAuth)
  Future<void> preparePrefs() async {
    ///Input : none
    ///Output : none
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sortHomePosts', 'Best');
    await prefs.setBool('isAuth', true);
  }

  ///check Whether the user name is avaliable or not
  ///
  ///take the user name and send it by API to the server
  ///retrn ture if the user name is not used and false otherwise

  Future<bool> availableUserName(userName) async {
    ///Input:
    ///   userName :- the user name of our user
    /// Output: return whether the name is avaliable or not
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
    return jsonDecode(response!.body)['available'];
  }

  ///change gender of the user
  ///
  ///take the gender and send it by API to the server
  ///used in the sign up or in settings when change the gneder

  Future<bool> changeGender(String Gender) async {
    ///Input :
    ///   gender: the new gender of the user
    /// output: return Whether the change gender done successfully or not
    http.Response? response = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') as String;

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

  ///change the userName of the user
  ///
  ///take the new user name and send it by API to the server

  Future<void> forgetUserName(Map<String, String> query) async {
    ///Input:
    /// query:- map that contain the the data that will be send to the server
    /// outPut: none
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

  ///change the Password of the user
  ///
  ///take the new password and send it by API to the server

  Future<void> forgetPassword(Map<String, String> query) async {
    ///Input:
    /// query:- map that contain the the data that will be send to the server
    /// outPut: none

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

  ///Authenticate the user by google API
  Future<void> GoogleAuth(Map<String, String> query) async {
    ///Input:
    /// query:- map that contain the the data that will be send to the server
    /// outPut: none

    try {
      final http.Response response =
          await http.post(Uri.parse(url + '/users/google/'), body: {
        'tokenId': query['id']
      }, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      error = (response.statusCode != 201) || (response.statusCode != 200);
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', json.decode(response.body)['token']);
        await prefs.setString(
            'expiresIn', json.decode(response.body)['expiresIn'].toString());
        await prefs.setString('userName', query['displayName:'] as String);
        preparePrefs();
      }
      notifyListeners();
    } catch (error) {
      print('error: $error');
    }
  }
}
