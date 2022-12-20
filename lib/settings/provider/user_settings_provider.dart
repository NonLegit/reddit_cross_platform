import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/all_prefrence.dart';
import '../models/blocked_users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';
import '../../widgets/custom_snack_bar.dart';

class UserSettingsProvider with ChangeNotifier {
  Prefrence? userPrefrence;
  BlockedUsers? allBlockedUsers;
  bool isError = false;
  String errorMessage = '';
  Prefrence? get getPrefrence {
    return userPrefrence;
  }

  Future<void> getAllPrefs(BuildContext context) async {
    try {
      String path = '/users/me/prefs';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(path);
      await DioClient.get(
        path: path,
      ).then((response) {
        isError = !(response.statusCode! < 300);
        if (isError == false) {
          Map<String, dynamic> data = response.data['prefs'];
          data['password'] = prefs.getString('password');
          data['sortHomePosts'] = prefs.getString('sortHomePosts');
          userPrefrence = Prefrence.fromJson(data);
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> ChangePrefs(
      Map<String, dynamic> data, BuildContext context) async {
    try {
      String path = '/users/me/prefs';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      // print(data);
      // print(path);
      await DioClient.patch(path: path, data: data).then((response) {
        isError = !(response.statusCode! < 300);
        if (isError) {
          errorMessage = json.decode(response.data)['errorMessage'];
          // print(isError);
          // print(errorMessage);
        } else {}
      });
      notifyListeners();
    } on DioError catch (e) {
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> getAllBlocked(BuildContext context) async {
    try {
      String path = '/users/blocked';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(path);
      await DioClient.get(
        path: path,
      ).then((response) {
        allBlockedUsers = BlockedUsers.fromJson(response.data);
        isError = !(response.statusCode! < 300);
        if (isError) {
          errorMessage = json.decode(response.data)['errorMessage'];
        }
        print(isError);
        print(errorMessage);
      });
      notifyListeners();
    } on DioError catch (e) {
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> blockUnblock(
      String userName, BuildContext context, bool willBlock) async {
    try {
      String path = '/users/${userName}/';
      print(path);
      path += (willBlock) ? 'block_user' : 'unblock_user';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(data: {}, path: path).then((response) {
        isError = !(response.statusCode! < 300);
        if (isError) {
          print('error');
          errorMessage = json.decode(response.data)['errorMessage'];
        } else {
          print('sucess');
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> changeEmail(
      Map<String, dynamic> userData, BuildContext context) async {
    try {
      String path = '/users/change_email';
      print(path);
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(data: userData, path: path).then((response) {
        // print('asdasd');
        isError = !(response.statusCode! < 310);
        if (isError) {
          print('error');
          errorMessage = json.decode(response.data)['errorMessage'];
        } else {
          print('sucess');
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      print('error $e');
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> changePassword(
      Map<String, dynamic> userData, BuildContext context) async {
    try {
      String path = '/users/change_password';
      print(path);
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(data: userData, path: path).then((response) {
        // print('asdasd');
        isError = !(response.statusCode! < 310);
        if (isError) {
          print('error');
          errorMessage = json.decode(response.data)['errorMessage'];
        } else {
          print('sucess');
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      print('error $e');
      isError = true;
      errorMessage = e.message;
      HandleError.errorHandler(e, context);
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
      HandleError.handleError(error.toString(), context);
    }
  }
}
