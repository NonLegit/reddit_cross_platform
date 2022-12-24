import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../networks/dio_client.dart';
import '../models/others_profile_data.dart';
import '../models/moderated_subreddit_user_data.dart';
import '../../widgets/handle_error.dart';

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
  // ===================================this function used to===========================================//
//==================fetch and set date===========================//
//moderatedSubredditUserName==> userName Of Subreddit
  Future<void> fetchAndSetOtherProfile(
      String otherUserName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/users/${otherUserName}/about')
          .then((response) {
        loadProfile = OtherProfileData.fromJson(response.data['user']);
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
  // ===================================this function used to===========================================//
//==================fetch and set date moderated Subreddit of user===========================//
  Future<void> fetchAndSetModeratedSubredditUser(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(
        path: '/subreddits/mine/moderator',
      ).then((response) {
        List<ModeratedSubbredditUserData> tempData = [];
        response.data['data'].forEach((subreedit) {
          tempData.add(ModeratedSubbredditUserData.fromJson(subreedit));
        });
        moderatedSubbredditUserData = tempData;
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
  // ===================================this function used to===========================================//
//==================invite otherusers to my moderated subreddit===========================//
//subredditName=> userName Of Subreddit
//userName=> user who i invite
  Future<bool> invitation(
      String subredditName, String userName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print('/subreddits/$subredditName/moderators/$userName');
      await DioClient.post(
          path: '/subreddits/$subredditName/moderators/$userName',
          data: {
            "permissions": {
              "all": true,
              "access": true,
              "config": true,
              "flair": true,
              "posts": true
            }
          }).then((response) {
      });
      notifyListeners();
      return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }  // ===================================this function used to===========================================//
//==================block otherusers===========================//
//userName=> user who i block
  Future<bool> blockUser(String userName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(path: '/users/${userName}/block_user', data: {});
      notifyListeners();
      return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }
  // ===================================the next two function used to===========================================//
//==================follow and unfollow otherusers===========================//
//subredditName=> userName Of Subreddit
//userName=> user who i follow/unfollow
  Future<bool> followUser(String userName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(path: '/users/${userName}/follow', data: {});
      notifyListeners();
      return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }

  Future<bool> unFollowUser(String userName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.post(path: '/users/${userName}/unfollow', data: {});
      notifyListeners();
      return true;
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }
}
