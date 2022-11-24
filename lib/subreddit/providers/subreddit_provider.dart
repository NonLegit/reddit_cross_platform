import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/subreddit_data.dart';
import 'dart:convert';

//using in heighest widget to use
class SubredditProvider with ChangeNotifier {
  SubredditData? loadSubreddit;

  SubredditData? get gettingSubredditeData {
    return loadSubreddit;
  }

  Future<void> fetchAndSetSubredddit(String subredditUserName) async {
    try {
      subredditName = subredditUserName;
      DioClient.init();
      await DioClient.get(path: subreddit).then((response) {
        print('lllllllllllllllllllllllllllllllllllll');
        print(response.data['data']);
        loadSubreddit = SubredditData.fromJson(response.data['data']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      //throw (error);
    }
  }
}
