import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/dio_client.dart';
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
  Future<bool> updateVotes(String id, int state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/posts/${id}/vote',
        data: {'dir': state},
        //query: {'dir': state}
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> savePost(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/posts/${id}/save',
        data: {},
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> unSavePost(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/posts/${id}/unsave',
        data: {},
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> deletePost(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.delete(
        path: '/posts/$id',
      );
      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> postAction(String id, String action) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.patch(
        path: '/posts/${id}/actions/${action}',
        data: {},
      );
      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> postModerationAction(String id, String action) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.patch(
        path: '/posts/${id}/moderate/${action}',
        data: {},
      );
      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> reportSpam(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.patch(
        path: '/posts/${id}/spam',
        data: {"dir": 1},
      );
      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
