import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';
import '../services/post_services.dart';
//import 'package:image_picker/image_picker.dart';

class postController extends GetxController {
 RxBool isPostSpoiler=false.obs;
 RxBool isPostNSFW=false.obs;
  RxBool isLoading = true.obs;
 final services = PostServices();
  Rx<TextEditingController> postTitle = TextEditingController().obs;
  Rx<TextEditingController> textPost = TextEditingController().obs;
  Rx<TextEditingController> urlPost = TextEditingController().obs;
  RxString typeOfPost = ''.obs;
  final formKey = GlobalKey<FormState>();
  List<XFile>? imageFileList = <XFile>[].obs;
  Rx<XFile> video=XFile("").obs;
  @override
  void onInit() {
    _fetchHouses();
    super.onInit();
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
