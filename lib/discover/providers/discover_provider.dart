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
// ===================================this function used to===========================================//
//==================fetch and set date===========================//
//topics==> topics of comminty
//page==> page number to fetch
//limit> limit of size data return
  Future<void> fetchAndSetDiscover(String topic,int page, int limit,BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(
          path: '/subreddits/${topic}/posts/like_reels',
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
