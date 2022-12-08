import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:post/createpost/widgets/subreddit_container.dart';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../networks/const_endpoint_data.dart';
import '../model/post_model.dart';
import '../services/post_services.dart';
//import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
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

  // VideoPlayerController? controller;

    final videoFile = Rx<File?>(null);

  final videoController = Rx<VideoPlayerController?>(null);

  @override
  void onInit() {
    getSubreddits();
    _fetchHouses();
    super.onInit();
  }

  getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      await DioClient.get(path:'$mySubreddits/subscriber').then((value) {
        print(value);
        value.data['data'].forEach((value1) {
          subscribedSubreddits.add(userSubredditsResponse.fromJson(value1));
        });
      });

      await DioClient.get(path:'$mySubreddits/moderator').then((value) {
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
          text: 'post text', //textPost.value.text,
          kind: 'self',
          owner: subredditToSubmitPost.value,
          ownerType: 'Subreddit',
          spoiler: false,
          nsfw: isPostNSFW.value,
          // sendReplies: '',
          // title: postTitle.value.text,
          // text: textPost.value.text,
          // flairId: "",
          // flairText: "",
          // kind: "",
          // nsfw: isPostNSFW.value,
          // owner: "",
          // ownerType: "subreddit",
          // scheduled: "",
          // sendReplies: "",
          // sharedFrom: "",
          // spoiler: isPostSpoiler.value,
          // suggestedSort: "",
          // url: "",
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
  playVideo() {
    if (videoController.value!.value.isPlaying) {
      videoController.value!.pause();
    } else {
      // If the video is paused, play it.
      videoController.value!.play();
    }
    update();
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
