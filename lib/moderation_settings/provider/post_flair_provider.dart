import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:post/networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/handle_error.dart';
import '../models/post_flair_model.dart';

class PostFlairProvider with ChangeNotifier {
  List<PostFlairModel> _flairsList = [];

  List<PostFlairModel> get flairList {
    return [..._flairsList];
  }
  Future<void> addNewFlair(subredditName, data, context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      final PostFlairModel post = data;
      await DioClient.post(
          path: '/subreddits/$subredditName/flair', data: post.toJson());
      _flairsList.add(data);
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> fetchFlair(subredditName, context) async {
    _flairsList = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/subreddits/$subredditName/flair')
          .then((value) {
        print(value);
        value.data['data'].forEach((element) {
          _flairsList.add(PostFlairModel.fromJson(element));
        });
      });
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> editFlair(subredditName, context, flairId, data) async {
    try {
      final PostFlairModel post = data;
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.patch(
          path: '/subreddits/$subredditName/flair/$flairId',
          data: post.toJson());
      _flairsList[_flairsList.indexWhere((element) => element.sId == flairId)] =
          data;
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> deleteFlair(subredditName, context, flairId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.delete(path: '/subreddits/$subredditName/flair/$flairId');
      _flairsList.removeWhere((element) => element.sId == flairId);
      notifyListeners();
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
