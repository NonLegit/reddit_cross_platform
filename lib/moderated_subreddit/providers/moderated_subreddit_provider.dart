import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      DioClient.init();
      await DioClient.get(path: subreddit).then((response) {
        loadSubreddit = ModeratedSubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }
}
