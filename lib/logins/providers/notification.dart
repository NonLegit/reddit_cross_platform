import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:post/networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationToken {
  static Future<void> getTokenOfNotification() async {
    FirebaseMessaging.instance.getToken().then((value) async {
      print('getTokenOfFirebase : $value');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('notificationToken', value!);
      // await sendTokenToDatabase(value);
      print('token is set in shared preference');
    });
  }

  static Future<void> sendTokenToDatabase(token) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      //http://localhost:8000/api/v1/users/notifications/token
      await DioClient.post(
          path: '/notifications/token', data: {"token": token});
    } on DioError catch (e) {
      //HandleError.errorHandler(e, context);
    } catch (error) {
      //HandleError.errorHandler(e, context);
    }
  }

  static Future<void> refreshToken() async {
    //FirebaseMessaging().onTokenRefresh.listen((event) { });
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      final prefs = await SharedPreferences.getInstance();
      final String currentToken = prefs.getString('notificationToken')!;
      print('token refresh: $token');
      print('token refresh: $currentToken');
      if (currentToken != token) {
        print('token refresh: $token');
        // add code here to do something with the updated token
        await prefs.setString('notificationToken', token);
        //await sendTokenToDatabase(token);
      }
    });
  }
}
