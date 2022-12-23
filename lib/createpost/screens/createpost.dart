///////////////////////BY ME///////////////////////////////////////////
import 'dart:convert';
import 'dart:io';

import 'package:post/delta_to_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:post/home/screens/home_layout.dart';
import 'dart:async';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/community_container.dart';
import '../../home/widgets/custom_upper_bar.dart';
import '../../icons/icon_broken.dart';
import '../controllers/posts_controllers.dart';
import '../screens/posttocommunity.dart';
import '../widgets/type_of_post.dart';
import '../widgets/type_of_post_web.dart';
import 'finalpost.dart';



import 'package:flutter_quill/flutter_quill.dart' as quill;


class CreatePostSCreen extends StatefulWidget {

  // const CreatePostSCreen({
  //    Key? key,
  //     this.name="",
  //    this.icon="",
  //  }) : super(key: key);
  //  final String icon;
  //  final String name;
  @override
  State<CreatePostSCreen> createState() => _CreatePostSCreenState();

}

class _CreatePostSCreenState extends State<CreatePostSCreen> {
  // const CreatePostSCreen({super.key});
  final ImagePicker imagePicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  final PostController controller = Get.put(
      PostController(),permanent: false
  );
  final HomeController controllerForHome = Get.put(
      HomeController(),permanent: false
  );
  Future<void>? initializeVideoPlayerFuture;

  @override
  void initState()
  {

    // TODO: implement initState
    if(Get.arguments[0]==0)
    {
      controller.isFromHomeDirect.value=true;
    }
    else
    {
      controller.isFromHomeDirect.value=false;
      controller.iconOfSubredditToSubmittPost.value=Get.arguments[1] ;
      controller.subredditToSubmitPost.value=Get.arguments[2] ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenSizeWidth = MediaQuery.of(context).size.width;

    final isDesktop = ScreenSizeWidth >= 700;
    final isMobile = ScreenSizeWidth < 700;
    if (isDesktop){
      return Obx(()=>
          Scaffold(
              backgroundColor: const Color(0xA2D4E4FA),
              appBar: PreferredSize( preferredSize: Size(700, 60),child: UpBar(controller: controllerForHome, controllerForCreatePost: controller,)),
              body:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 600.0),
                      child: Text("Create a Post",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 600.0),
                      child: Container(
                          width: 300,
                          height: 50,
                          color: Colors.white,
                          child:PopupMenuButton<int>(

                            child: Row(
                              children: [
                                // Icon(Icons.home_filled),
                                SizedBox(width: 20,),
                                Text("choose a community"),
                                SizedBox(width: 80,),
                                Icon(Icons.arrow_drop_down_sharp)
                              ],
                            ),
                            elevation: 0,
                            color: Colors.white,
                            offset:Offset(0,35) ,
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                  value:1,
                                  child: Container(
                                    width: 300,
                                    child: Column(
                                        children:List.generate(controller.moderatedSubreddits.length, (index) => CommunityContainer(nameOfSubreddit: controller.moderatedSubreddits[index].subredditName!, iconOfSubreddit: controller.moderatedSubreddits[index].icon!))
                                    ),
                                  )

                              ),
                              PopupMenuItem(
                                  value:2,
                                  child: Container(
                                    width: 300,
                                    child: Column(
                                        children:List.generate(controller.subscribedSubreddits.length, (index) => CommunityContainer(nameOfSubreddit: controller.subscribedSubreddits[index].subredditName!, iconOfSubreddit: controller.subscribedSubreddits[index].icon!))
                                    ),
                                  )

                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 150),
                      child: Row(
                        children: [

                          InkWell(
                            onTap: (){
                              controller.typeOfPost.value = "self";
                              controller.typeOfPost.update((val) { });

                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 0.5)
                              ),
                              child: Center(

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.post_add,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 3,),
                                    Text(
                                        "Post",
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              controller.imageFileList!.clear();
                              selectImages();
                              print(
                                  "lenght of list is ${controller.imageFileList!.length}");
                              controller.typeOfPost.value = "image";
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 0.5)
                              ),
                              child: Center(

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 3,),
                                    Text(
                                        "Images ",
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              controller.videoFile.value=null;
                              controller.videoController.value=null;
                              controller.getVideo();
                              controller.typeOfPost.value = "video";
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 0.5)
                              ),
                              child: Center(

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.video_camera_back_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 3,),
                                    Text(
                                        "Video",
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              controller.typeOfPost.value = "link";
                              controller.typeOfPost.update((val) { });
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 0.5)
                              ),
                              child: Center(

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.link,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 3,),
                                    Text(
                                        "Link",
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 1000,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),

                      child:TextFormField(
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
                            hintText: "Title",
                            border:OutlineInputBorder(
                                borderSide: BorderSide(width: 20,color: Colors.black)
                            )),
                      ),
                    ),
                    SizedBox(height: 20,),
                    BuildFormTypeWeb(controller:controller),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: Row(
                        children: [
                          /// Spoiler
                          InkWell(
                            onTap: (){
                              if (controller.isPostSpoiler.value == false) {
                                controller.isPostSpoiler.value = true;
                                controller.isPostSpoiler.refresh();
                              } else {
                                controller.isPostSpoiler.value = false;
                                controller.isPostSpoiler.refresh();
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              decoration: BoxDecoration(
                                  color:(controller.isPostSpoiler.value==true)? Colors.red:Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add,
                                    color: Colors.black,
                                    size: 20,),
                                  const SizedBox(width: 5,),
                                  Text(
                                      "Spoiler",
                                      style:TextStyle(color: Colors.black)
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          /// NSFW
                          InkWell(
                            onTap: (){
                              if (controller.isPostNSFW.value == false) {
                                controller.isPostNSFW.value = true;
                                controller.isPostNSFW.refresh();
                              } else {
                                controller.isPostNSFW.value = false;
                                controller.isPostNSFW.refresh();
                              }
                            },

                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              decoration: BoxDecoration(
                                  color:(controller.isPostNSFW.value==true)? Colors.red:Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add,
                                    color: Colors.black,size: 20,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "NSFW",
                                    style:  TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 700,),
                          InkWell(
                            onTap: (){
                              if(controller.postTitle.value.text!=""&&controller.formKeyUrl.currentState!.validate())
                              {
                                controller.sendPost(context,
                                  title: controller.postTitle.value.text,
                                  text: (DeltaToHTML.encodeJson(controller.textPost.value.document.toDelta().toJson())).toString(),
                                  kind: controller.typeOfPost.value,
                                  url: controller.urlPost.value.text,
                                  owner: (controller.idOfSubredditToSubmittPost.value),
                                  ownerType:"Subreddit" ,
                                  nsfw: controller.isPostNSFW.value,
                                  spoiler: controller.isPostSpoiler.value,
                                );
                                controller.postTitle.value.clear();
                                controller.urlPost.value.clear();
                                controller.textPost.value.clear();
                                controller.isPostSpoiler.value=false;
                                controller.isPostNSFW.value=false;
                                // Navigator.pop(context);
                                Get.to(HomeLayoutScreen());
                              }
                              else return;
                            },

                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              decoration: BoxDecoration(
                                  color:(controller.postTitle.value.text=="")? Colors.white:Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Row(
                                children: const [
                                  SizedBox(width: 5,),
                                  Text(
                                    "Post",
                                    style:  TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              )
          ),
      );
    }
    return Obx(()=>
        WillPopScope(
          onWillPop: () async {
            final value = ( controller.imageFileList!.length>0 || controller.videoFile.value != null || controller.urlPost.value.text != "")?await
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
                                const Text(
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
                                          Get.back();
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
                                          controller.videoController.value=null;
                                          controller.urlPost.value.clear();
                                          Get.to(HomeLayoutScreen());
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
                          //  Get.delete<PostController>();
                          Get.back();
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
                            if (  controller.formKeyUrl.currentState!.validate() && controller.postTitle.value.text !="") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              if(controller.isFromHomeDirect.value==true)
                              {
                                Get.to(BuildSubreddit());
                              }
                              else
                              {
                                Get.to(FinalPost());
                              }
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
                  SizedBox(height: 10,),
                  Visibility(
                    visible: !controller.isFromHomeDirect.value,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 14),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: ()
                            {
                              Get.to(BuildSubreddit());
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('${controller.iconOfSubredditToSubmittPost}'),
                                  radius: 16.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Get.to(BuildSubreddit());
                                  },
                                  icon: Text(
                                    controller.subredditToSubmitPost.value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  label: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all<double>(0),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                            child: Center(
                                                child: Text(
                                                    "Community Standards"))),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                              Colors.blue[900],
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "understand",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              child: const Text(
                                "Rules",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                            controller.typeOfPost.value = "self";
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
                            controller.typeOfPost.value = "link";
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
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<PostController>();
    super.dispose();
  }
  void selectImages() async {
    final List<File>? selectedImages = (await imagePicker.pickMultiImage()).cast<File>();
    if (selectedImages!.isNotEmpty) {
      controller.imageFileList!.addAll(selectedImages);
    }
  }
}
