import 'package:flutter/material.dart';
import 'package:post/comments/models/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networks/dio_client.dart';

class PostCommentsProvider with ChangeNotifier {
  late List<CommentModel> commentsData;

  List<CommentModel>? get gettingPostComments {
    return commentsData;
  }

  Future<void> fetchPostComments(String postId, int limit, int depth) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(path: '/comments/comment_tree/$postId', query: {
        'limit': limit,
        'depth': depth,
      }).then((response) {
        print(response.data);
        List<CommentModel> tempData = [];
        response.data['comments'].forEach((comment) {
          tempData.add(CommentModel.fromJson(comment));
        });
        commentsData = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }

  Future<bool> postComment(
      String parentId, String parentType, String text) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/comments',
        data: {'parent': parentId, 'parentType': parentType, 'text': text},
        //query: {'dir': state}
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

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

  Future<bool> saveComments(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/comments/${id}/save',
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

  Future<bool> unSaveComment(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.post(
        path: '/comments/${id}/unsave',
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

  Future<bool> deleteComment(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await DioClient.init(prefs);
      var res = await DioClient.delete(
        path: '/comments/$id',
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
