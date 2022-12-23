import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:post/myprofile/models/myprofile_data.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../comments/models/comment_model.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../networks/dio_client.dart';
import '../../post/models/post_model.dart';

class HomeController extends GetxController with StateMixin<List<PostModel>> {
  RxString sortHistoryBy="upvoted".obs;
  RxString sortHomePostsBy="best".obs;
  RxString sortAllBy="hot".obs;

  Rx<IconData>allIcon=Icons.local_fire_department_rounded.obs;
  RxInt pageNumber=1.obs;
  List<PostModel>homePosts=<PostModel>[].obs;
  List<PostModel>allPosts=<PostModel>[].obs;
  List<PostModel>userSavedPosts=<PostModel>[].obs;
  List<CommentModel>userSavedComments=<CommentModel>[].obs;
  // List<PostModel>upvotedPosts=<PostModel>[].obs;
  // List<PostModel>downvotedPosts=<PostModel>[].obs;
  // List<PostModel>hiddenPosts=<PostModel>[].obs;
  List<PostModel>historyPosts=<PostModel>[].obs;
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

   ///////// for scrol in home//////////////////////////
  ScrollController myScroll =ScrollController();

  /// true when posts are loading.
  RxBool isLoading = false.obs;

  /// true when error occurred
  RxBool error = false.obs;
///////////////////////for in all//////////////
  ScrollController myScrollAll =ScrollController();
RxInt pageNumberAll=1.obs;
  /// true when posts are loading.
  RxBool isLoadingAll = false.obs;

  /// true when error occurred
  RxBool errorAll = false.obs;
//////History//////////////
  RxInt pageNumberHistory=1.obs;
  /// true when posts are loading.
  RxBool isLoadingHistory = false.obs;

  /// true when error occurred
  RxBool errorHistory = false.obs;
//////////////SAVED/////////////
  RxInt pageNumberSaved=1.obs;
  /// true when posts are loading.
  RxBool isLoadingSaved = false.obs;

  /// true when error occurred
  RxBool errorSaved = false.obs;

  //////////////SAVEDCOMMENTS/////////////
  RxInt pageNumberComment=1.obs;
  /// true when posts are loading.
  RxBool isLoadingCommetns = false.obs;

  /// true when error occurred
  RxBool errorComment = false.obs;


  @override
  void onInit() {
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
  Future getSavedPosts({required int p,}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/saved?page=${p}&limit=20',
      );
      if(response.statusCode==200)
      {
        for (var post in response.data['savedPosts'])
        {
          PostModel  temp =PostModel();
          await temp.fromJson(post);
          userSavedPosts.add(temp);
        }
      }
      else {
        await showToast(response.statusMessage.toString());
        errorSaved.value=true;
      }
      isLoadingSaved.value=false;
    } catch (error) {
      print("error in fetching history posts $error");
      change([], status: RxStatus.error(error.toString()));
    }
  }
  Future getSavedComments({required int p}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/saved?page=${p}&limit=20',
      );
      if(response.statusCode==200)
      {
        for (var comment in response.data['savedComments'])
        {
          userSavedComments.add(CommentModel.fromJson(comment));
        }
      }
      else {
        await showToast(response.statusMessage.toString());
        errorComment.value=true;
      }
      isLoadingCommetns.value=false;
    } catch (error) {
      print("error in fetching saved comments $error");
      change([], status: RxStatus.error(error.toString()));
    }
  }
  Future getHistory({required String sort,required int p}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/${sort}?page=${p}&limit=20',
      );
      if(response.statusCode==200)
      {
        for (var post in response.data['posts'])
        {
          PostModel  temp =PostModel();
          await temp.fromJson(post);
          historyPosts.add(temp);
        }
      }
      else {
        await showToast(response.statusMessage.toString());
        errorHistory.value=true;
      }
      isLoadingHistory.value=false;
    } catch (error) {
      print("error in fetching history posts $error");
      change([], status: RxStatus.error(error.toString()));
    }
  }
  Future getPosts({required String sort,required int p}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/${sort}?page=${p}&limit=20',
      );
      if(response.statusCode==200)
        {
          for (var post in response.data['data'])
            {
              PostModel  temp =PostModel();
              await temp.fromJson(post);
              homePosts.add(temp);
            }
              // response.data["data"].forEach((value1) async{
              //   PostModel  temp =PostModel();
              //  await temp.fromJson(value1);
              //   homePosts.add(temp);
              // });
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
  Future getPostsInAll({required String sort,required int p}) async {
    // isLoading.value=true;
    // error.value=false;
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =await DioClient.get(
        path:'/users/${sort}?page=${p}&limit=20',
      );
      if(response.statusCode==200)
      {
        for (var post in response.data['data'])
          {
            PostModel temp =PostModel();
            await temp.fromJson(post);
            allPosts.add(temp);
          }
      }
      else {
        await showToast(response.statusMessage.toString());
        error.value=true;
      }
      isLoading.value=false;
      print("the length of returned list in all is ${homePosts.length}");
      print("${homePosts[0]}");
    } catch (error) {
      print("error in fetching all posts $error");
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
