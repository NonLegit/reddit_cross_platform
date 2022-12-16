import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/others_profile_data.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/moderated_subreddit_user_data.dart';

//using in heighest widget to use
class OtherProfileprovider with ChangeNotifier {
  OtherProfileData? loadProfile;
  List<ModeratedSubbredditUserData>? moderatedSubbredditUserData;
  OtherProfileData? get gettingOtherProfileData {
    return loadProfile;
  }

  List<ModeratedSubbredditUserData>? get gettingModeratedSubreddit {
    return moderatedSubbredditUserData;
  }

  Future<void> fetchAndSetOtherProfile(String otherUserName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      print(otherUserName);
      // print(userName);
      await DioClient.get(path: '/users/${otherUserName}/about')
          .then((response) {
        print(response.data['user']);
        loadProfile = OtherProfileData.fromJson(response.data['user']);
        notifyListeners();
      });
    } catch (error) {
      print('eeeeeeeeeeeeeeeee');
      print(error);
      throw (error);
    }
  }

  Future<void> fetchAndSetModeratedSubredditUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print('12ssdsadsadsada ');
      await DioClient.get(
        path: '/subreddits/mine/moderator',
      ).then((response) {
        print('erorrr  ${response.statusCode}');
        print(response);
        List<ModeratedSubbredditUserData> tempData = [];
        response.data['data'].forEach((subreedit) {
          tempData.add(ModeratedSubbredditUserData.fromJson(subreedit));
        });
        moderatedSubbredditUserData = tempData;
        notifyListeners();
      });
    } catch (error) {
      // print('12 ');
      // print('heelo');
      print(error);
      throw (error);
    }
  }

  Future<bool> invitation(
      String subredditUserName, String moderatorName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      await DioClient.post(
          path: '/subreddits/${subredditName}/moderators/${moderatorName}',
          data: {}).then((value) => print(value));
      notifyListeners();
      return true;
    } catch (error) {
      print('error in invitaion : $error');
      return false;
    }
  }

  Future<bool> blockUser(String userName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      print(userName);
      DioClient.init(prefs);
      await DioClient.post(path: '/users/${userName}/block_user', data: {});
      notifyListeners();
      return true;
    } catch (error) {
      print('blocked error $error');
      return false;
    }
  }

  Future<bool> followUser(String userName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      print(userName);
      DioClient.init(prefs);
      print('users/${userName}/follow');
      await DioClient.post(path: 'users/${userName}/follow', data: {});
      notifyListeners();
      return true;
    } catch (error) {
      print('Follow error $error');
      return false;
    }
  }

  Future<bool> unFollowUser(String userName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      print(userName);
      DioClient.init(prefs);
      await DioClient.post(path: '/users/${userName}/unfollow', data: {});
      notifyListeners();
      return true;
    } catch (error) {
      print('UnFollow error $error');
      return false;
    }
  }
}
