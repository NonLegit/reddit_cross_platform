import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';
import '../models/traffic.dart';
import '../models/moderation_posts.dart';

class ModerationGeneralDataProvider with ChangeNotifier {
  late Traffic dayTraffic;
  late Traffic weekTraffic;
  late Traffic monthTraffic;
  late Traffic yearTraffic;
  late ModerationPosts posts;
  bool isError = false;
  String errorMessage = '';

  Future<void> gettrafficData(
      String subRedditName, BuildContext context) async {
    // If the topic changed call patch to update the community topic
    // subRedditName = 'khaled subreddit';
    try {
      final path1 = '/subreddits/traffic/$subRedditName/day';
      final path2 = '/subreddits/traffic/$subRedditName/week';
      final path3 = '/subreddits/traffic/$subRedditName/month';
      final path4 = '/subreddits/traffic/$subRedditName/year';

      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;

      //  final response =
      Response response1 = await DioClient.get(path: path1);
      Response response2 = await DioClient.get(path: path2);
      Response response3 = await DioClient.get(path: path3);
      Response response4 = await DioClient.get(path: path4);
      print('asdasdasdasdsaasdsadasdsad');
      print(response1);
      // print(response2);

      // print(response3);
      // print(response4);

      isError = !(response1.statusCode! < 310) &&
          !(response2.statusCode! < 310) &&
          !(response3.statusCode! < 310) &&
          !(response4.statusCode! < 310);
      // if (isError) {
      //   errorMessage = json.decode(response.data)['errorMessage'];
      //   print(isError);
      //   print(errorMessage);
      // } else {
      dayTraffic = Traffic.fromJson(response1.data);
      weekTraffic = Traffic.fromJson(response2.data);
      monthTraffic = Traffic.fromJson(response3.data);
      yearTraffic = Traffic.fromJson(response4.data);
      // }

      notifyListeners();
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> patchPosts(
      String postId, String action, BuildContext context) async {
    //If the topic changed call patch to update the community topic
    try {
      String path = '/posts/$postId/moderate/$action';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      //  final response =
      await DioClient.patch(path: path, data: {}).then((response) {
        isError = !(response.statusCode! < 300);
        if (isError) {
          errorMessage = json.decode(response.data)['errorMessage'];
          print(isError);
          print(errorMessage);
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> getPosts(
      String name, String location, sortType, BuildContext context) async {
    //If the topic changed call patch to update the community topic
    // subRedditName = 'khaled subreddit';
    try {
      final path =
          '/subreddits/$name/about/posts/${location.toLowerCase()}?sort=$sortType';

      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      final Response response = await DioClient.get(
        path: path,
      );

      isError = !(response.statusCode! < 310);
      if (isError) {
        errorMessage = json.decode(response.data)['errorMessage'];
      } else {
        posts = ModerationPosts.fromJson(response.data);
      }

      notifyListeners();
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
