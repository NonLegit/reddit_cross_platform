import '../post/models/post_model.dart';

import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

//using in heighest widget to use
class SubredditPostProvider with ChangeNotifier {
  List<PostModel>? postData;

  List<PostModel>? get gettingSubredditPostData {
    return postData;
  }

  Future<void> fetchSubredditePosts(
      String subredditName, String postType, int page, int limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(
          path: '/subreddits/${subredditName}/${postType}',
          query: {'page': page, 'limit': limit}).then((response) async {
        List<PostModel> tempData = [];
        for (var post in response.data['posts']) {
          PostModel temp = PostModel();
          await temp.fromJson(post);
          tempData.add(temp);
        }
        postData = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }
}
