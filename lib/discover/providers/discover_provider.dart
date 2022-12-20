import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';
import '../../networks/dio_client.dart';
import '../models/discover_data.dart';

//using in heighest widget to use
class DiscoverProvider with ChangeNotifier {
  DiscoverData? imgAndVideoList;

  DiscoverData? get gettingImagesAndVideo {
    return imgAndVideoList;
  }

  Future<void> fetchAndSetDiscover(String topic,int page, int limit,BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print('====================in discover================================');
      print('/subreddits/${topic}/posts/like_reels$page p $limit L');
      await DioClient.get(
          path: '/subreddits/study/posts/like_reels',
          query: {'page': page, 'limit': limit}).then((response) {
        print(response.data);
        imgAndVideoList = DiscoverData.fromJson(response.data);

        notifyListeners();
      });
    }  on DioError catch (e) {
        HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
