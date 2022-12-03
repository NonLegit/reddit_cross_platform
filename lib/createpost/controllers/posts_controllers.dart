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
  List<userSubredditsResponse> mySubredditsInPost = <userSubredditsResponse>[];
  RxBool isPostSpoiler = false.obs;
  RxBool isPostNSFW = false.obs;
  RxBool isLoading = true.obs;
  final services = PostServices();
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  Rx<TextEditingController> textPost = TextEditingController().obs;
  Rx<TextEditingController> urlPost = TextEditingController().obs;
  RxString typeOfPost = ''.obs;
  final formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = <XFile>[].obs;
  Rx<XFile> video = XFile("").obs;
  @override
  void onInit() {
    _fetchHouses();
    getSubreddits();
    super.onInit();
  }

  Future<void> getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    print(
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    try {
      print("$mySubreddits/emssssssssanfdggggggggggg");
      DioClient.get(path: '$mySubreddits/subscriber')
          .then((value) => value.data['subreddits'].forEach((value1) {
                print(value1);
                print(userSubredditsResponse.fromJson(value1).subredditName);
                mySubredditsInPost.add(userSubredditsResponse.fromJson(value1));
              }));
      DioClient.get(path: '${mySubreddits}/moderator')
          .then((value) => value.data['subreddits'].forEach((value1) {
                mySubredditsInPost.add(userSubredditsResponse.fromJson(value1));
              }));
      print('hellodfaddddddddddd');
      print(mySubredditsInPost);
    } catch (error) {
      print(error);
    }
  }

  sendPost(BuildContext context) {
    services.sendPost(
        PostModel(
          title: postTitle.value.text,
          text: textPost.value.text,
          flairId: "",
          flairText: "",
          kind: "",
          nsfw: "",
          owner: "",
          ownerType: "",
          scheduled: "",
          sendReplies: "",
          sharedFrom: "",
          spoiler: "",
          suggestedSort: "",
          url: "",
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
}
