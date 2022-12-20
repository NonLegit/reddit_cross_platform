import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../post/models/post_model.dart';
import '../models/comments_data.dart';
import '../../networks/dio_client.dart';
import '../../widgets/handle_error.dart';
//using in heighest widget to use
class ProfileProvider with ChangeNotifier {
  List<CommentsData> commentsdata=[];
 List<PostModel> data=[];

  List<CommentsData>? get gettingProfileComments {
    return commentsdata;
  }
List<PostModel>? get gettingProfilePostData {
    return data;
  }

  Future<void> fetchandSetProfileComments(
      String userName, int page, int limit,BuildContext context) async {
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
        commentsdata..addAll( tempData);
        notifyListeners();
      });
    } on DioError catch (e) {
        HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
Future<void> fetchProfilePosts(
      String userName, String postType, int page, int limit,BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(path: '/users/${userName}/posts',
              query: {'sort': postType, 'page': page, 'limit': limit})
          .then((response) async {
        List<PostModel> tempData = [];
        for (var post in response.data['posts']) {
          PostModel temp = PostModel();
          await temp.fromJson(post);
          tempData.add(temp);
        }
        data ..addAll(tempData);
        notifyListeners();
      });
    }on DioError catch (e) {
        HandleError.errorHandler(e, context,);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }


}
