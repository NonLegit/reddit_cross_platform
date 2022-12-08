import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/moderated_subreddit_data.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//using in heighest widget to use
class ModeratedSubredditProvider with ChangeNotifier {
  ModeratedSubredditData? loadSubreddit;

  ModeratedSubredditData? get gettingSubredditeData {
    return loadSubreddit;
  }

  Future<void> fetchAndSetModeratedSubredddit(
      String moderatedSubredditUserName) async {
    try {
      subredditName = moderatedSubredditUserName;
      print('******************************HERE*****************************');
      print(subredditName);
      print(subreddit);
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/subreddits/$subredditName').then((response) {
        print(response.data);
        loadSubreddit = ModeratedSubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }
}
