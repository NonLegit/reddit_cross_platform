import 'dart:collection';

import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/notification_class_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  NotificationsClassModel? notificationClassModel;
  List<Map> list = [];

  List<Map> get returnNotification {
    return [...list];
  }

//Get notification
  Future<bool> getNotification() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      final response =
          await DioClient.get(path: notificationResults).then((value) {
        print(value.data['data']);
        value.data['data'].forEach((value1) {
          list.add(HashMap.from(value1));
        });
      });
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      // notifyListeners();
      return false;
    }
  }
}
