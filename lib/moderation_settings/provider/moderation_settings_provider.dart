import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/moderator_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';
class ModerationSettingProvider with ChangeNotifier {
  ModeratorToolsModel? moderatorToolsModel1;
  bool isError = false;
  String errorMessage = '';
  ModeratorToolsModel? get moderatorToolsModel {
    return moderatorToolsModel1;
  }

  Future<void> getCommunity(String userName,BuildContext context) async {
    //Return the moderated community data to get the topic choosen before if exist
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      print(subredditName);
      print(subreddit);
      await DioClient.get(path: '/subreddits/$subredditName').then((response) {
        print(response.data['data']);
        moderatorToolsModel1 =
            ModeratorToolsModel.fromJson(response.data['data']);
        isError = (response.statusCode! < 300);
        if (isError) {
          errorMessage = json.decode(response.data)['errorMessage'];
        }
        print(isError);
        print(errorMessage);

        print(moderatorToolsModel!.choosenTopic1);
      });
      notifyListeners();
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> patchCommunity(
      Map<String, dynamic> data, String userName,BuildContext context) async {
    //If the topic changed call patch to update the community topic
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      //  final response =
      await DioClient.patch(path: '/subreddits/$subredditName', data: data)
          .then((response) {
        isError = (response.statusCode! < 300);
        if (isError) {
          errorMessage = json.decode(response.data)['errorMessage'];
          print(isError);
          print(errorMessage);
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
