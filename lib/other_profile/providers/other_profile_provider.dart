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
 List< ModeratedSubbredditUserData> ?moderatedSubbredditUserData;
  OtherProfileData? get gettingOtherProfileData {
    return loadProfile;
  }
 List< ModeratedSubbredditUserData> ? get gettingModeratedSubreddit{
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
        print(response.data['data']);
        loadProfile = OtherProfileData.fromJson(response.data['data']);
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

      await DioClient.get(
          path: '/subreddits/mine/moderator',
         ).then((response) {
        print(response.data);
        List<ModeratedSubbredditUserData> tempData = [];
        response.data['subreddits'].forEach((subreedit) {
          tempData.add(ModeratedSubbredditUserData.fromJson(subreedit));
        });
        moderatedSubbredditUserData = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }
 Future<bool> invitation(String subredditUserName,  String moderatorName) async {
    try {
   final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      await DioClient.post(path:'/subreddits/${subredditName}/moderators/${moderatorName}',
       );
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
  Future<bool> blockUser(String userName) async {
    try {
   final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      await DioClient.post(path:'/users/${userName}/block_user',
       );
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}

