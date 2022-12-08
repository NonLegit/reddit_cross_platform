import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../createpost/model/post_model.dart';
import '../../networks/dio_client.dart';

class HomeController extends GetxController with StateMixin<List<PostModel>> {

  List<userSubredditsResponse> recentlyVisited = <userSubredditsResponse>[].obs;
  //List<userSubredditsResponse>myCommunities=<userSubredditsResponse>[].obs;
  List<userSubredditsResponse> following = <userSubredditsResponse>[].obs;
  RxBool isRecentlyVisitedPannelExpanded = true.obs;
  RxBool isModeratingPannelExpanded = true.obs;
  RxBool isFollowingPannelExpanded = true.obs;
  RxBool isYourCommunitiesPannelExpanded = true.obs;

  @override
  void onInit() {

    getPosts();
    super.onInit();
  }

  Future getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      await DioClient.get(
        path: '/posts',
      ).then((value) {
        print(value);
        List<PostModel> data = value.data.map((e) => PostModel.fromJson(value));
        change(data, status: RxStatus.success());
      });
    } catch (error) {
      print(error);
      change([], status: RxStatus.error(error.toString()));
    }
  }
}
