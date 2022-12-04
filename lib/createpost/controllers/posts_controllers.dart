import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:post/createpost/widgets/subreddit_container.dart';
import 'package:post/networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networks/const_endpoint_data.dart';
import '../model/post_model.dart';
import '../services/post_services.dart';
//import 'package:image_picker/image_picker.dart';

class postController extends GetxController {
  List<userSubredditsResponse> subscribedSubreddits =
      <userSubredditsResponse>[].obs;
  List<userSubredditsResponse> moderatedSubreddits =
      <userSubredditsResponse>[].obs;
  RxString subredditToSubmitPost = "".obs;
  RxBool isPostSpoiler = false.obs;
  RxBool isPostNSFW = false.obs;
  RxBool isLoading = true.obs;
  final services = PostServices();
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  Rx<TextEditingController> textPost = TextEditingController().obs;
  Rx<TextEditingController> urlPost = TextEditingController().obs;
  RxString typeOfPost = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = <XFile>[].obs;
  Rx<XFile> video = XFile("").obs;
  @override
  void onInit() {
    getSubreddits();
    _fetchHouses();
    super.onInit();
  }

  Future<void> getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      print('/subreddits/mine');
      await DioClient.get(path: '/subreddits/mine/subscriber').then((value) {
        print(value);
        value.data['data'].forEach((value1) {
          subscribedSubreddits.add(userSubredditsResponse.fromJson(value1));
        });
      });

      await DioClient.get(path: '/subreddits/mine/moderator').then((value) {
        print(value);
        value.data['data'].forEach((value1) {
          moderatedSubreddits.add(userSubredditsResponse.fromJson(value1));
        });
      });
    } catch (error) {
      print(error);
    }
  }

  sendPost(BuildContext context) {
    services.sendPost(
        PostModel(
          title: postTitle.value.text,
          text: textPost.value.text,
          kind: 'self',
          owner: "asd",
          ownerType: 'Subreddit',
          spoiler: false,
          nsfw: isPostNSFW.value,
          sendReplies: '',
        ),
        context);
  }

  Future<void> _fetchHouses() async {
    try {
      ///here fitch Your Posts
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPost() async {
    try {
      isLoading.value = true;

      ///here post Your Posts
      await Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    } finally {
      isLoading(false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    postTitle.close();
    urlPost.close();
    textPost.close();
    super.dispose();
  }
}
