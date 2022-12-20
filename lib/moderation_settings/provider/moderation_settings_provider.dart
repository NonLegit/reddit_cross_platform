import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/moderator_tools.dart';
import '../models/moderators.dart';
import '../models/approved.dart';
import '../models/banned.dart';
import '../models/muted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';
import '../models/user.dart';

class ModerationSettingProvider with ChangeNotifier {
  ModeratorToolsModel? moderatorToolsModel1;
  List<Moderators>? moderators = [];
  List<Banned>? banned = [];
  List<Muted>? muted = [];
  List<Approved>? approved = [];
  bool isError = false;
  String errorMessage = '';
  ModeratorToolsModel? get moderatorToolsModel {
    return moderatorToolsModel1;
  }

  Future<void> getCommunity(String userName, BuildContext context) async {
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
        isError = !(response.statusCode! < 300);
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

  Future<void> getUser(
      String userName, UserCase userCase, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      print(subredditName);
      print(subreddit);
      String path = '/subreddits/$subredditName/';
      if (userCase == UserCase.moderator) {
        path += 'moderators';
      } else if (userCase == UserCase.banned) {
        path += 'banned';
      } else if (userCase == UserCase.approved) {
        path += 'approved_users';
      } else if (userCase == UserCase.muted) {
        path += 'muted';
      }
      print('before response');
      print(path);
      await DioClient.get(path: path).then((response) {
        print('inside response');

        print(response.data['data']);
        print(response.data['data'].runtimeType);
        if (userCase == UserCase.moderator) {
          moderators = (response.data['data'] as List<dynamic>).map((e) {
            Map<String, Object> myMap = Map<String, Object>.from(e);
            print(myMap);
            return Moderators.fromJson(myMap);
          }).toList();
        } else if (userCase == UserCase.banned) {
          banned = (response.data['data'] as List<dynamic>).map((e) {
            Map<String, Object> myMap = Map<String, Object>.from(e);
            print(myMap.runtimeType);
            return Banned.fromJson(myMap);
          }).toList();
        } else if (userCase == UserCase.muted) {
          muted = (response.data['data'] as List<dynamic>).map((e) {
            Map<String, Object> myMap = Map<String, Object>.from(e);
            print(myMap.runtimeType);
            return Muted.fromJson(myMap);
          }).toList();
        } else if (userCase == UserCase.approved) {
          approved = (response.data['data'] as List<dynamic>).map((e) {
            Map<String, Object> myMap = Map<String, Object>.from(e);
            print(myMap.runtimeType);
            return Approved.fromJson(myMap);
          }).toList();
        }
      });
      print('after response');
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') as String;
  }

  String getSubredditName(context) {
    return ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as String
        : '';
    // return 'Cooking';
  }

  Future<void> patchCommunity(
      Map<String, dynamic> data, String userName, BuildContext context) async {
    //If the topic changed call patch to update the community topic
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      //  final response =
      await DioClient.patch(path: '/subreddits/$subredditName', data: data)
          .then((response) {
        isError = !(response.statusCode! < 300);
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