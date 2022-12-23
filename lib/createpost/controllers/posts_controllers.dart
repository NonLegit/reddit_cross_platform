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
  Rx<TextEditingController> tryanderror = TextEditingController().obs;
  List<userSubredditsResponse> subscribedSubreddits =
      <userSubredditsResponse>[].obs;
  List<userSubredditsResponse> moderatedSubreddits =
      <userSubredditsResponse>[].obs;
  RxString subredditToSubmitPost = "".obs;
  RxString iconOfSubredditToSubmittPost="".obs;
  RxString idOfSubredditToSubmittPost="".obs;
  RxBool showMore=false.obs;
  RxBool isPostSpoiler = false.obs;
  RxBool isPostNSFW = false.obs;
  RxBool isLoading = true.obs;
  final services = PostServices();
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  Rx<quill.QuillController> textPost=quill.QuillController.basic().obs;
  Rx<TextEditingController> urlPost = TextEditingController().obs;

  RxString typeOfPost = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyUrl = GlobalKey<FormState>();
  List<File>? imageFileList = <File>[].obs;

  Future<void>? initializeVideoPlayerFuture;

  // File? videoFile;
  final videoFile = Rx<File?>(null);
  final videoController = Rx<VideoPlayerController?>(null);
//Flairs belonging to subreddit
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
  // @override
  // onClose()
  // {
  //
  //   typeOfPost.value='';
  //   super.onClose();
  // }
  getFlairsOfSubreddit() async{
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try{
      print('/subreddit/${subredditToSubmitPost}/flairs');
      await DioClient.get(path:'/subreddits/${subredditToSubmitPost}/flair').then((value){
        print("Flairs returned are $value");
        value.data['data'].forEach((val)
        {
          flairsOfSubreddit.add(FlairModel.fromJson(val));
        });
      });
      checking = List<bool>.filled(flairsOfSubreddit.length+1, false);
      print("the size of returned list of flairs of subreddit is ${flairsOfSubreddit.length}");
      print("the size of checking list is  ${checking.length}");
    }
    catch(e){
      print("error in fetching the flairs of ${subredditToSubmitPost} subreddit -> $e");
    }

  }
  getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      await DioClient.get(path:'$mySubreddits/subscriber').then((value) {
        print("subs list $value");
        value.data['data'].forEach((value1) {
          subscribedSubreddits.add(userSubredditsResponse.fromJson(value1));
          print("name of ${subscribedSubreddits[0].subredditName}");
        });
      });

      await DioClient.get(path:'$mySubreddits/moderator').then((value) {
        print("moderator list $value");
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
