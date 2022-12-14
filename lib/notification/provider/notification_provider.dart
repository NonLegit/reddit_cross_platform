import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../../widgets/handle_error.dart';
import '../models/notification_class_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  NotificationModel? notificationClassModel;
  List<NotificationModel> list = [];

  List<NotificationModel> get returnNotification {
    return [...list];
  }

//Get notification
  Future<void> getNotification(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      final response =
          await DioClient.get(path: notificationResults).then((value) {
        print(value.data['data']);
        print(value);
        // value.data['data'].forEach((value1) {
        //   print(value1.runtimeType);
        //   print('fghjkl');

          notificationClassModel = NotificationModel.fromJson(value.data['data']);

          list.add(notificationClassModel!);
       // });
      });
      notifyListeners();
      // return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }
  Future<void> markAllAsRead(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
          await DioClient.patch(path: '/users/notifications/mark_as_read');
      notifyListeners();
      // return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  //http://localhost:8000/api/v1/users/notifications/{notificationId}/hide
  Future<void> markAndHideThisNotification(BuildContext context,notificationId,type) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      //type ==> hide or mark_as_read
          await DioClient.patch(path: '/users/notifications/{$notificationId}/$type');
      notifyListeners();
      // return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }



}
