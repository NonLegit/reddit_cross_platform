import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../post/models/post_model.dart';
import '../models/comments_data.dart';
import '../networks/dio_client.dart';
import '../widgets/handle_error.dart';

//using in heighest widget to use
class ProfileProvider with ChangeNotifier {
  List<CommentsData> commentsdata = [];
  List<PostModel> data = [];
  List<Map<String, dynamic>> commentsAndPosts = [];
  List<CommentsData>? get gettingProfileComments {
    return commentsdata;
  }

  List<PostModel>? get gettingProfilePostData {
    return data;
  }

  List<Map<String, dynamic>>? get gettingPostCommentData {
    return commentsAndPosts;
  }

  Future<void> fetchandSetProfileComments(
      String userName, int page, int limit, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(
          path: '/users/${userName}/comments',
          query: {'page': page, 'limit': limit}).then((response) {
        List<CommentsData> tempData = [];
        response.data['posts'].forEach((post) {
          tempData.add(CommentsData.fromJson(post));
        });
        commentsdata = tempData;
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> fetchProfilePosts(String userName, String postType, int page,
      int limit, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(
              path: '/users/${userName}/posts',
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
    } on DioError catch (e) {
      HandleError.errorHandler(
        e,
        context,
      );
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> fetchandSetProfilePostsAndComments(String userName,
      String postType, int page, int limit, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(
              path: '/users/${userName}/overview',
              query: {'sort': postType, 'page': page, 'limit': limit})
          .then((response) {
        List<Map<String, dynamic>> tempData = [];
        response.data['comments'].forEach((comment) {
          tempData
              .add({'type': 'comment', 'data': CommentsData.fromJson(comment)});
        });

        response.data['posts'].forEach((post) {
          PostModel temp = PostModel();
          temp.fromJson(post);
          tempData.add({'type': 'post', 'data': temp});
        });

        commentsAndPosts = tempData;
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
