import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/create_community/screens/post.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:post/myprofile/models/myprofile_data.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../networks/dio_client.dart';
import '../../post/models/post_model.dart';

class HomeController extends GetxController with StateMixin<List<PostModel>> {
  RxString sortHomePostsBy="best".obs;
  RxInt pageNumber=0.obs;
  List<PostModel>homePosts=<PostModel>[].obs;
   RxBool isRecentlyVisitedDrawer=false.obs;
  List<userSubredditsResponse> recentlyVisited = <userSubredditsResponse>[
  ].obs;
  //List<userSubredditsResponse>myCommunities=<userSubredditsResponse>[].obs;
  List<userSubredditsResponse> following = <userSubredditsResponse>[].obs;
  RxBool isRecentlyVisitedPannelExpanded = true.obs;
  RxBool isModeratingPannelExpanded = true.obs;
  RxBool isFollowingPannelExpanded = true.obs;
  RxBool isYourCommunitiesPannelExpanded = true.obs;
   MyProfileData? myProfile ;

  /// true when posts are loading.
  RxBool isLoading = false.obs;

  /// true when error occurred
  RxBool error = false.obs;

  /// Indicate that more posts are fetched
  RxBool gettingPosts = false.obs;



  //late AnimationController loadingSpinnerAnimationController;
// final ScrollController _controller = ScrollController();


  @override
  void onInit() {
    //getPosts();

    getInfoOfMe();
    super.onInit();
  }
  Future<void> getInfoOfMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: myprofile).then((response) {
        print("the data of my profile are ${response.data['user']}");
        myProfile = MyProfileData.fromJson(response.data['user']);
      });
    } catch (error) {
      print("there is an error in fetching the data of my profile the error is -> $error");
    }
  }
  Future getPosts() async {
    isLoading.value=true;
    error.value=false;
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/${sortHomePostsBy}?page=${pageNumber}&limit=5',
      );
      //     .then((value) {
      //   print(value);
      //   // List<PostModel> data = value.data.map((e) => PostModel.fromJson(value));
      //   // change(data, status: RxStatus.success());
      //   value.data["data"].forEach((value1){
      //     homePosts.add(PostModel.fromJson(value1));
      //   });
      // });

      if(response.statusCode==200)
        {
              pageNumber++;
              response.data["data"].forEach((value1){
                homePosts.add(PostModel.fromJson(value1));
              });
        }
      else {
        await showToast(response.statusMessage.toString());
        error.value=true;
      }
      isLoading.value=false;
      print("the length of returned list in home is ${homePosts.length}");
      print("${homePosts[0]}");
    } catch (error) {
      print("error in fetching home posts $error");
      change([], status: RxStatus.error(error.toString()));
    }
  }
  Future<void> getMorePosts() async {
    if (gettingPosts.value) {
      return;
    }
    gettingPosts.value = true;
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/${sortHomePostsBy}?page=${pageNumber}&limit=5',
      );
      //     .then((value) {
      //   print(value);
      //   // List<PostModel> data = value.data.map((e) => PostModel.fromJson(value));
      //   // change(data, status: RxStatus.success());
      //   value.data["data"].forEach((value1){
      //     homePosts.add(PostModel.fromJson(value1));
      //   });
      // });

      if(response.statusCode==200)
      {
        pageNumber++;
        response.data["data"].forEach((value1){
          homePosts.add(PostModel.fromJson(value1));
        });
      }
      else {
        await showToast(response.statusMessage.toString());
     gettingPosts.value=false;
      }

      print("the length of returned list in home is ${homePosts.length}");
      print("${homePosts[0]}");
    } catch (error) {
      print("error in fetching home posts $error");
      change([], status: RxStatus.error(error.toString()));
    }
  }

  Future<void> showToast(final String msg) async {
    await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
