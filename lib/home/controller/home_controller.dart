import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:post/createpost/widgets/subreddit_container.dart';
import 'package:post/networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../createpost/controllers/posts_controllers.dart';
class HomeController extends GetxController
{
  final postController controller = Get.put(
    postController(),
  );
  List<userSubredditsResponse>recentlyVisited=<userSubredditsResponse>[].obs;
  //List<userSubredditsResponse>myCommunities=<userSubredditsResponse>[].obs;
  List<userSubredditsResponse>following=<userSubredditsResponse>[].obs;
  RxBool isRecentlyVisitedPannelExpanded = true.obs;
  RxBool isModeratingPannelExpanded = true.obs;
  RxBool isFollowingPannelExpanded = true.obs;
  RxBool isYourCommunitiesPannelExpanded = true.obs;
 @override
  void onInit() {
   controller.getSubreddits();
    super.onInit();
  }

}
