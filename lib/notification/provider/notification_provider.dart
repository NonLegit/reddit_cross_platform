import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../../widgets/handle_error.dart';
import '../models/notification_class_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  NotificationModel? notificationClassModel;
  List<NotificationModel> listToday = [];
  List<NotificationModel> listEariler = [];
  int? count;
  initState() {
    count = 0;
  }

  //int counter = 0;
  List<NotificationModel> get returnTodayNotification {
    return [...listToday];
  }

  List<NotificationModel> get returnEarlierNotification {
    return [...listEariler];
  }

  void appendToList(NotificationModel notificationClassModel) {
    if (DateTime.now()
            .difference(
                DateTime.parse(notificationClassModel.createdAt.toString()))
            .inDays >
        1) {
      listEariler.add(notificationClassModel);
    } else {
      listToday.add(notificationClassModel);
    }
    notifyListeners();
  }

//Get notification
  Future<void> getNotification(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      listToday = [];
      listEariler = [];
      final response =
          await DioClient.get(path: notificationResults).then((value) {

        value.data['data'].forEach((value1) {
          notificationClassModel = NotificationModel.fromJson(value1);
          if (DateTime.now()
                  .difference(DateTime.parse(
                      notificationClassModel!.createdAt.toString()))
                  .inDays >
              1) {
            if (!listEariler.contains(notificationClassModel)) {
              listEariler.add(notificationClassModel!);
            }
          } else {
            if (!listToday.contains(notificationClassModel)) {
              listToday.add(notificationClassModel!);
            }
          }
        });
      });
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> markAllAsRead(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.patch(path: '/users/notifications/mark_as_read');
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
  Future<void> markAndHideThisNotification(
      BuildContext context, notificationId, type, i) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      if (type == 'hide') {
        (i == 1)
            ? listEariler
                .removeWhere((element) => element.sId == notificationId)
            : listToday.removeWhere((element) => element.sId == notificationId);
      }
      await DioClient.patch(path: '/users/notifications/$notificationId/$type');
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
