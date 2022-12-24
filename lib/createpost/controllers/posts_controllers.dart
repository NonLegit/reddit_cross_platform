import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../home/models/flairs.dart';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../networks/const_endpoint_data.dart';
import '../services/post_services.dart';

class PostController extends GetxController {
  /// List of subscribed subreddits of user
  List<userSubredditsResponse> subscribedSubreddits =
      <userSubredditsResponse>[].obs;
  /// List of moderated subreddits of user
  List<userSubredditsResponse> moderatedSubreddits =
      <userSubredditsResponse>[].obs;
  RxString subredditToSubmitPost = "".obs;
  RxString iconOfSubredditToSubmittPost="".obs;
  RxString idOfSubredditToSubmittPost="".obs;
  RxBool showMore=false.obs;
  /// check whether post is spoiler or not
  RxBool isPostSpoiler = false.obs;
  /// check whether post is nsfw or not
  RxBool isPostNSFW = false.obs;
  RxBool isLoading = true.obs;
  final services = PostServices();
  /// The title of post
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  /// The text of post
  Rx<quill.QuillController> textPost=quill.QuillController.basic().obs;
  /// URL if post is link
  Rx<TextEditingController> urlPost = TextEditingController().obs;
  /// To select the type of post whether link or self or video or image
  RxString typeOfPost = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyUrl = GlobalKey<FormState>();
  List<File>? imageFileList = <File>[].obs;
/// To initialise the video player
  Future<void>? initializeVideoPlayerFuture;

  // File? videoFile;
  final videoFile = Rx<File?>(null);
  /// Control the video playing or pause...
  final videoController = Rx<VideoPlayerController?>(null);
/// Flairs belonging to subreddit
  List<FlairModel>flairsOfSubreddit=<FlairModel>[].obs;
  RxString idOfFlair="".obs;
  RxString textOfFlair="".obs;
  RxString textColorOfFlair="None".obs;
  RxString backgroundColorOfFlair="None".obs;
  RxBool isSubredditHasFlair=false.obs;
  RxBool isFromHomeDirect=true.obs;
  List<bool>checking=<bool>[].obs;
  RxInt checkFromWhich=0.obs;
  dynamic argumentData = Get.arguments;
  @override
  void onInit()
  {
    getSubreddits();
    super.onInit();
  }
  /// Function to get all the flairs of subreddit belonging to a certain user
  getFlairsOfSubreddit() async{
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try{
      await DioClient.get(path:'/subreddits/${subredditToSubmitPost}/flair').then((value){
        value.data['data'].forEach((val)
        {
          flairsOfSubreddit.add(FlairModel.fromJson(val));
        });
      });
      checking = List<bool>.filled(flairsOfSubreddit.length+1, false);
    }
    catch(e){
      print("error in fetching the flairs of ${subredditToSubmitPost} subreddit -> $e");
    }
  }
  /// Function to get all the subreddit belonging to a certain user
  getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      await DioClient.get(path:'$mySubreddits/subscriber').then((value) {
        value.data['data'].forEach((value1) {
          subscribedSubreddits.add(userSubredditsResponse.fromJson(value1));
        });
      });

      await DioClient.get(path:'$mySubreddits/moderator').then((value) {
        value.data['data'].forEach((value1) {
          moderatedSubreddits.add(userSubredditsResponse.fromJson(value1));
        });
      });
    } catch (error) {
      print("error in fething subreddits of user $error");
    }
  }
  Future<String> sendPost(BuildContext context, {required String title,required String text,required String kind ,required String url,required String owner,required String ownerType,required bool nsfw,required bool spoiler}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    var response ;
    try {
      response= await DioClient.post(path: "/posts", data:{
        "title": title ,
        "kind": kind,
        "text":text,
        "url":url,
        "owner":owner,
        "ownerType": ownerType,
        "nsfw": nsfw ,
        "spoiler": spoiler  ,
        "sendReplies": true,
        "suggestedSort":"hot"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("sent successfuly",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );
      }
      return response.data["data"]["_id"];
    } catch (e) {
      print("error in sending the post -> $e");
      return "";
    }
  }
  /// To send a post to a subreddit including flairs
  Future<String> sendPostWithFlair(BuildContext context, {required String title,required String text,required String kind ,required String url,required String owner,required String ownerType,required bool nsfw,required bool spoiler,required String textFlair,required String idFlair}) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    var response ;
    try {
      response = await DioClient.post(path: "/posts", data: {
        "title": title,
        "kind": kind,
        "text": text,
        "url": url,
        "owner": owner,
        "ownerType": ownerType,
        "nsfw": nsfw,
        "spoiler": spoiler,
        "sendReplies": true,
        "flairId": idOfFlair,
        "flairText": textOfFlair,
        "suggestedSort":"hot"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("sent successfuly",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );
      }
      return response.data["data"]["_id"];
    }
    catch (e) {
      print("error in sending the post -> $e");
      return "";
    }
  }


  Future<void> createPost() async {
    try {
      isLoading.value = true;

      /// Here post Your Posts
      await Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    } finally {
      isLoading(false);
    }
  }
  /// To get video from galary
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
/// To play or pause video
  playVideo() {
    if (videoController.value!.value.isPlaying) {
      videoController.value!.pause();
    } else {
      // If the video is paused, play it.
      videoController.value!.play();
    }
    update();
  }
/// Ensure disposing of the VideoPlayerController to free up resources.
  @override
  void dispose() {

    videoController.value!.dispose();
    postTitle.close();
    urlPost.close();
    textPost.close();
    typeOfPost.close();
    super.dispose();
  }


}
