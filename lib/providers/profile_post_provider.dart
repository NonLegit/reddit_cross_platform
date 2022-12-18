import '../post/models/post_model.dart';
import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import './profile_post.dart';

//using in heighest widget to use
class ProfilePostProvider with ChangeNotifier {
  List<PostModel>? data;

  List<PostModel>? get gettingProfilePostData {
    print('=========================True Get Post data=====================');
    return data;
  }

  Future<void> fetchProfilePosts(
      String userName, String postType, int page, int limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(path: '/users/${userName}/posts',
              //  query: {'sort': 'New'}
              query: {'sort': postType, 'page': page, 'limit': limit})
          .then((response) async {
        List<PostModel> tempData = [];
        for (var post in response.data['posts']) {
          PostModel temp = PostModel();
          await temp.fromJson(post);
          tempData.add(temp);
        }
        data = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }
}
