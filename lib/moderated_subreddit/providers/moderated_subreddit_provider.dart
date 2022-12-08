import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/moderated_subreddit_data.dart';
import 'dart:convert';

//using in heighest widget to use
class ModeratedSubredditProvider with ChangeNotifier {
 ModeratedSubredditData? loadSubreddit;

  ModeratedSubredditData? get gettingSubredditeData {
    return loadSubreddit;
  }

  Future<void> fetchAndSetModeratedSubredddit(String moderatedSubredditUserName) async {
    try {
      subredditName = moderatedSubredditUserName;
       final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      await DioClient.get(path: '/subreddits/$moderatedSubredditUserName').then((response) {
        loadSubreddit = ModeratedSubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }
   Future<bool> joinAndDisjoinModeratedSubreddit(String moderatedSubredditUserName,  Map<String, dynamic>? query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      await DioClient.post(path:'subreddits/${moderatedSubredditUserName}/subscribe',query:query
       //data: data
       );
      notifyListeners();
      return true;
    } catch (error) {
      // print(error);
      //notifyListeners();
      return false;
    }
  }
}
