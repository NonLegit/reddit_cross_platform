import 'package:flutter/material.dart';
import '../../widgets/handle_error.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../../models/subreddit_data.dart';

//using in heighest widget to use
class SubredditProvider with ChangeNotifier {
  SubredditData? loadSubreddit;
  bool showTheme = false;
  SubredditData? get gettingSubredditeData {
    return loadSubreddit;
  }

  bool? get gettingTheme {
    return showTheme;
  }
  // ===================================this function used to===========================================//
//==================fetch and set date===========================//
//moderatedSubredditUserName==> userName Of Subreddit
  Future<void> fetchAndSetSubredddit(
      String subredditUserName, BuildContext context) async {
    try {
      subredditName = subredditUserName;
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/subreddits/${subredditUserName}')
          .then((response) {
        loadSubreddit = SubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
 // ===================================this function used to===========================================//
//==================Join and Disjoin subbreddit ===========================//
//moderatedSubredditUserName==> userName Of Subreddit
//action==> action either sub or unsub
  Future<bool> joinAndDisjoinSubreddit(
      String subredditUserName, String action, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      DioClient.init(prefs);
      await DioClient.post(
        path: '/subreddits/${subredditUserName}/subscribe',
        data: {},
        query: {'action': action},
      );
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

  Future<void> togglingTheme() async {
    showTheme = !showTheme;
    notifyListeners();
  }
}
