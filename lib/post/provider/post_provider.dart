import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  late PostModel postData;

//Get post
  // Future<PostModel> getPost(String postID) async {
  //   postId = postID;
  //   try {
  //     await DioClient.get(path: post).then((value) {
  //       print(value);
  //       postData = PostModel.fromJson(value.data['data']);
  //       notifyListeners();
  //     });
  //   } catch (error) {
  //     throw error;
  //   }
  //   return postData;
  // }
  ///This function is used to call the api end point to update the vote of a post
  ///
  //post
  updateVotes(String id, int state) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    print(id);
    print('posts/${id}/vote');
    DioClient.post(
        path: 'posts/${id}/vote', data: {}, query: {'dir': state.toString()});
  }
}
