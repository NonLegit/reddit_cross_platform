import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../../models/subreddit_data.dart';
import '../../widgets/handle_error.dart';

//using in heighest widget to use
class ModeratedSubredditProvider with ChangeNotifier {
 SubredditData? loadSubreddit;

 SubredditData? get gettingSubredditeData {
    return loadSubreddit;
  }

  Future<void> fetchAndSetModeratedSubredddit(
      String moderatedSubredditUserName, BuildContext context) async {
    try {
      subredditName = moderatedSubredditUserName;
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/subreddits/$subredditName').then((response) {
        print(response.data['data']);
        loadSubreddit =SubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<bool> joinAndDisjoinModeratedSubreddit(
      String moderatedSubredditUserName,
      String action,
      BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.post(
          path: '/subreddits/${moderatedSubredditUserName}/subscribe',
          query: {'action': action},
          data: {});
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
