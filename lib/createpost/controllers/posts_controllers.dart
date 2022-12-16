import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../home/models/flairs.dart';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../networks/const_endpoint_data.dart';
import '../model/send_post_model.dart';
import '../services/post_services.dart';
//import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  List<userSubredditsResponse> subscribedSubreddits =
      <userSubredditsResponse>[].obs;
  List<userSubredditsResponse> moderatedSubreddits =
      <userSubredditsResponse>[].obs;
  RxString subredditToSubmitPost = "".obs;
  RxString iconOfSubredditToSubmittPost = "".obs;
  RxBool showMore = false.obs;
  RxBool isPostSpoiler = false.obs;
  RxBool isPostNSFW = false.obs;
  RxBool isLoading = true.obs;
  final services = PostServices();
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  Rx<TextEditingController> textPost = TextEditingController().obs;
  Rx<quill.QuillController> quillController = quill.QuillController.basic().obs;
  Rx<TextEditingController> urlPost = TextEditingController().obs;
  RxString typeOfPost = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyUrl = GlobalKey<FormState>();
  List<XFile>? imageFileList = <XFile>[].obs;

  Future<void>? initializeVideoPlayerFuture;

  // File? videoFile;
  final videoFile = Rx<File?>(null);
  final videoController = Rx<VideoPlayerController?>(null);
//Flairs belonging to subreddit
  List<FlairModel> flairsOfSubreddit = <FlairModel>[].obs;
  RxString idOfFlair = "".obs;
  RxString textOfFlair = "".obs;
  RxString textColorOfFlair = "None".obs;
  RxString backgroundColorOfFlair = "None".obs;
  RxBool isSubredditHasFlair = false.obs;
  List<bool> checking = <bool>[].obs;
  RxBool isFromHomeDirect = true.obs;

  RxInt checkFromWhich = 0.obs;
  RxString name = "".obs;
  RxString icon = "".obs;

  @override
  void onInit() {
    _fetchHouses();
    getSubreddits();
    super.onInit();
  }

  getFlairsOfSubreddit() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      print('/subreddit/${subredditToSubmitPost}/flairs');
      await DioClient.get(path: '/subreddits/${subredditToSubmitPost}/flair')
          .then((value) {
        print("Flairs returned are $value");
        value.data['data'].forEach((val) {
          flairsOfSubreddit.add(FlairModel.fromJson(val));
        });
      });
      checking = List<bool>.filled(flairsOfSubreddit.length + 1, false);
      print(
          "the size of returned list of flairs of subreddit is ${flairsOfSubreddit.length}");
      print("the size of checking list is  ${checking.length}");
    } catch (e) {
      print(
          "error in fetching the flairs of ${subredditToSubmitPost} subreddit -> $e");
    }
  }

  getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      await DioClient.get(path: '$mySubreddits/subscriber').then((value) {
        print(value);
        value.data['data'].forEach((value1) {
          subscribedSubreddits.add(userSubredditsResponse.fromJson(value1));
          print("name of ${subscribedSubreddits[0].subredditName}");
        });
      });

      await DioClient.get(path: '$mySubreddits/moderator').then((value) {
        print(value);
        value.data['data'].forEach((value1) {
          moderatedSubreddits.add(userSubredditsResponse.fromJson(value1));
          print("DDDDDDDDDDDDDDDDD");
        });
      });
      print("the length of moderated sub is ${moderatedSubreddits.length}");
      print("the length of subscribed sub is ${subscribedSubreddits.length}");
    } catch (error) {
      print("error in fething subreddits of user $error");
    }
  }

  sendPost(BuildContext context) {
    services.sendPost(
        SendPostModel(
          title: postTitle.value.text,
          text: textPost.value.text, //textPost.value.text,
          kind: typeOfPost.value,
          owner: subredditToSubmitPost.value,
          ownerType: 'Subreddit',
          spoiler: isPostSpoiler.value,
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

  Future getVideo() async {
    Future<XFile?> videoFiles =
        ImagePicker().pickVideo(source: ImageSource.gallery);
    videoFiles.then((file) async {
      videoFile.value = File(file!.path);
      videoController.value = VideoPlayerController.file(videoFile.value!);
      update();
      // Initialize the controller and store the Future for later use.
      initializeVideoPlayerFuture = videoController.value!.initialize();

      // Use the controller to loop the video.
      videoController.value!.setLooping(true);
    });
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
    // Ensure disposing of the VideoPlayerController to free up resources.
    videoController.value!.dispose();
    postTitle.close();
    urlPost.close();
    textPost.close();
    typeOfPost.close();
    super.dispose();
  }
}
