import 'dart:collection';

import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/notification_class_model.dart';

class NotificationProvider with ChangeNotifier {
  NotificationsClassModel? notificationClassModel;
  List<Map> list = [];

  List<Map> get returnNotification {
    return [...list];
  }

//Get community using name the user typed to check if it existed before or not
// return true if existed
// false if it doesn't exist before
  Future<bool> getNotification() async {
    try {
      final response =
          await DioClient.get(path: notificationResults).then((value) {
        value.data.forEach((value1) {
          list.add(HashMap.from(value1));
        });
      });
      notifyListeners();
      return true;
    } catch (error) {
      // print(error);
      // notifyListeners();
      return false;
    }
  }
}
