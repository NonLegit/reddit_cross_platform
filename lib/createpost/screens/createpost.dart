///////////////////////BY ME///////////////////////////////////////////
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:post/home/screens/home_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import '../../icons/icon_broken.dart';
import '../controllers/posts_controllers.dart';
import '../screens/posttocommunity.dart';
import '../widgets/type_of_post.dart';
import 'finalpost.dart';

class CreatePostSCreen extends StatefulWidget {
  @override
  State<CreatePostSCreen> createState() => _CreatePostSCreenState();
}

class _CreatePostSCreenState extends State<CreatePostSCreen> {
  // const CreatePostSCreen({super.key});
  final ImagePicker imagePicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  final PostController controller = Get.put(
    PostController(),
  );
  Future<void>? initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       WillPopScope(
        onWillPop: () async {
            final value = (controller.textPost.value.text != "" || controller.imageFileList!.length>0 || controller.videoFile.value != null || controller.urlPost.value.text != "")?await
              showDialog(context: context,
                builder: (context)
                {
                  return AlertDialog(
                    content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 0.001,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 10,
                        child: (
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Discard Post Submission?',
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                          ),
                                        ),
                                        child:
                                        const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.textPost.value.clear();
                                          controller.postTitle.value.clear();
                                          controller.imageFileList!.clear();
                                          controller.videoFile.value=null;
                                          controller.urlPost.value.clear();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>homeLayoutScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red[700],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                          ),
                                        ),
                                        child:
                                        const Text(
                                          'Discard',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                        )
                    ),
                  );
                }
            ) : null ;

           if (value!=null)
             {
               return Future.value(value);
             }else
             {
             return  Future.value(true);
             }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black45, icon: Icon(
                      Icons.close,
                      size: 32.0,
                    ),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20.0),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : MaterialButton(
                                onPressed: () {
                                  if (  controller.formKeyUrl.currentState!.validate() ) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                    Get.to(BuildSubreddit());
                                  }
                                },
                                elevation: 0.0,
                                height: 35.0,
                                minWidth: 80.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: controller.postTitle.value.text == ""
                                    ? Colors.grey[100]
                                    : Colors.blue[900],
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                      ),

                  ],
                ),
             Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        controller.postTitle.refresh();
                      },
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                      controller: controller.postTitle.value,
                      enabled: true,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                      showCursor: true,
                      cursorColor: Colors.blue,
                      cursorHeight: 20.0,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          hintText: "An interesting title",
                          border: InputBorder.none),
                    ),
                  ),

                const SizedBox(
                  height: 10.0,
                ),

                const SizedBox(
                  height: 10.0,
                ),
                Expanded(child: BuildFormType(controller: controller,)),
                    Padding(
                        padding: const EdgeInsetsDirectional.only(start: 20, bottom: 10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.typeOfPost.value = "text";
                              },
                              icon: const Icon(IconBroken.Document),
                            ),
                            IconButton(
                                onPressed: () async {
                                  controller.imageFileList!.clear();
                                  selectImages();
                                  print(
                                      "lenght of list is ${controller.imageFileList!.length}");
                                  controller.typeOfPost.value = "image";
                                },
                                icon: const Icon(IconBroken.Image_2)),
                            IconButton(
                              onPressed: () {
                                controller.videoFile.value=null;
                                controller.videoController.value=null;
                                controller.getVideo();
                                controller.typeOfPost.value = "video";
                              },
                              icon: const Icon(IconBroken.Video),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.typeOfPost.value = "url";
                              },
                              icon: const Icon(IconBroken.Bookmark),
                            ),
                          ],
                        ),
                      ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      controller.imageFileList!.addAll(selectedImages);
    }
  }
}
