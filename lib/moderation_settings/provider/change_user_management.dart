import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import '../models/moderator_tools.dart';
import '../models/moderators.dart';
import '../models/banned.dart';
import '../models/muted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';

class ChangeUserManagementProvider with ChangeNotifier {
  ModeratorToolsModel? moderatorToolsModel1;
  bool isError = false;
  String errorMessage = '';
  ModeratorToolsModel? get moderatorToolsModel {
    return moderatorToolsModel1;
  }

  Future<void> invideModerator(String subredditName, String userName,
      ModeratorPermissions permissions, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print('/subreddits/$subredditName/moderators/$userName');
      await DioClient.post(
          path: '/subreddits/$subredditName/moderators/$userName',
          data: {"permissions": permissions.toJson()}).then((response) {
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

  Future<void> deleteModerator(
      String subredditName, String userName, BuildContext context) async {
    try {
      String path = '/subreddits/${subredditName}/moderators/${userName}';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(path);
      await DioClient.delete(path: path).then((response) {
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

  Future<void> changePermissionsModerator(String subredditName, String userName,
      ModeratorPermissions permissions, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print('/subreddits/$subredditName/moderators/$userName');
      await DioClient.patch(
          path: '/subreddits/$subredditName/moderators/$userName',
          data: {"permissions": permissions.toJson()}).then((response) {
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

  Future<void> addRemoveApproved(String subredditName, String userName,
      BuildContext context, bool willApprove) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      String action = (willApprove == true) ? 'approve' : 'disapprove';
      print('/subreddits/$subredditName/$userName/$action/approve_user');
      await DioClient.post(
              data: {},
              path: '/subreddits/$subredditName/$userName/$action/approve_user')
          .then((response) {
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

  Future<void> addRemoveMuted(String subredditName, String userName,
      BuildContext context, MuteInfo mutedInfo, bool willMute) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      String action = (willMute == true) ? 'mute' : 'unmute';
      print('/subreddits/$subredditName/mute_settings/$action/$userName');
      await DioClient.post(
              data: mutedInfo.toJson(),
              path:
                  '/subreddits/$subredditName/mute_settings/$action/$userName')
          .then((response) {
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

  Future<void> addRemoveBanned(String subredditName, String userName,
      BuildContext context, Baninfo banInfo, bool willbane) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      String action = (willbane == true) ? 'ban' : 'unban';
      print('/subreddits/$subredditName/Ban_settings/$action/$userName');
      await DioClient.post(
              data: banInfo.toJson(), //ther will be data here
              path: '/subreddits/$subredditName/Ban_settings/$action/$userName')
          .then((response) {
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
}
