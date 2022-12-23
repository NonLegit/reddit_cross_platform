import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:post/createpost/model/send_post_model.dart';
import '../../delta_to_html.dart';
import '../../home/screens/home_layout.dart';
import '../../icons/icon_broken.dart';
import '../controllers/posts_controllers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/post_services.dart';
import 'flair_list.dart';

class FinalPost extends StatefulWidget {
  @override
  State<FinalPost> createState() => _FinalPostState();
}

class _FinalPostState extends State<FinalPost> {
  // const FinalPost({Key? key}) : super(key: key);
  final PostController controller = Get.put(
      PostController(),permanent: false
  );
  final services = PostServices();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // SizedBox(height: 40.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: IconButton(

                    color: Colors.black, onPressed: () {
                    Get.back();
                  }, icon:Icon( IconBroken.Arrow___Left_2,size: 32.0),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 1.w),
                  child: MaterialButton(
                    onPressed: () {
                      print( controller.postTitle.value.text);
                      print(( controller.postTitle.value.text as String).runtimeType);
                      print(controller.typeOfPost.value);
                      print((DeltaToHTML.encodeJson(controller.textPost.value.document.toDelta().toJson())).toString());
                      print(controller.urlPost.value.text);
                      print(controller.idOfSubredditToSubmittPost.value);
                      print((controller.subredditToSubmitPost.value == "Myprofile")?"User":"Subreddit");
                      print(controller.isPostNSFW.value);
                      print(controller.isPostSpoiler.value);
                      print("send replies ->true");
                      print("flair id ${controller.idOfFlair.value}");
                      print("text of flair ${controller.textOfFlair.value}");
                      print("suggested sort hot");
                      print("scheduled false");
                      print("print data on submit");
                      Future<String> str;
                      if(controller.idOfFlair.value=="")
                      {
                        str=controller.sendPost(context,
                          title: controller.postTitle.value.text,
                          text: (DeltaToHTML.encodeJson(
                              controller.textPost.value.document.toDelta()
                                  .toJson())).toString(),
                          kind: controller.typeOfPost.value,
                          url: controller.urlPost.value.text,
                          owner: (controller.idOfSubredditToSubmittPost
                              .value),
                          ownerType: controller.subredditToSubmitPost.value=="Myprofile"?"User":"Subreddit",
                          nsfw: controller.isPostNSFW.value,
                          spoiler: controller.isPostSpoiler.value,
                        );
                      }
                      else
                      {
                        str= controller.sendPostWithFlair(context,
                          title: controller.postTitle.value.text,
                          text: (DeltaToHTML.encodeJson(
                              controller.textPost.value.document.toDelta()
                                  .toJson())).toString(),
                          kind: controller.typeOfPost.value,
                          url: controller.urlPost.value.text,
                          owner: (controller.idOfSubredditToSubmittPost
                              .value),
                          ownerType:controller.subredditToSubmitPost.value=="Myprofile"?"User":"Subreddit",
                          nsfw: controller.isPostNSFW.value,
                          spoiler: controller.isPostSpoiler.value, textFlair: controller.textOfFlair.value, idFlair: controller.idOfFlair.value,
                        );
                      }
                      if(controller.typeOfPost.value=="image")
                      {
                        for(int i=0;i<controller.imageFileList!.length;i++)
                        {
                          services.uploadImage(controller.imageFileList![i],str);
                        }
                      }
                      if(controller.typeOfPost.value=="video")
                      {
                        services.uploadImage(controller.videoFile.value!,str);
                      }
                      controller.postTitle.value.clear();
                      controller.urlPost.value.clear();
                      controller.textPost.value.clear();
                      controller.isPostSpoiler.value = false;
                      controller.isPostNSFW.value = false;
                      controller.typeOfPost.value='';
                      Get.to(HomeLayoutScreen());
                    },
                    elevation: 0.0,
                    height: 40.0,
                    minWidth: 80.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.blue[900],
                    child: Text(
                      "post",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Row(
                children: [
                  Row(
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
                          Get.back();
                          controller.isPostNSFW.value = false;
                          controller.isPostSpoiler.value = false;
                        },
                        icon: Text(
                          controller.subredditToSubmitPost.value,
                          style: TextStyle(color: Colors.black),
                        ),
                        label: Icon(
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
                  Spacer(),
                  TextButton(
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Center(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Expanded(
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
                      child: Text(
                        "Rules",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                onChanged: (value) {
                  controller.postTitle.value;
                },
                controller: controller.postTitle.value,
                readOnly: true,
                style: TextStyle(fontSize: 20.0),
                maxLines: 2,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(50.0),
                    )),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (controller.isPostNSFW.value == false) {
                        controller.isPostNSFW.value = true;
                        controller.isPostNSFW.refresh();
                      } else {
                        controller.isPostNSFW.value = false;
                        controller.isPostNSFW.refresh();
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize:
                      MaterialStateProperty.all(Size(130.0, 20.0)),
                      backgroundColor: (controller.isPostNSFW.value)
                          ? MaterialStateProperty.all(
                        Colors.black87,
                      )
                          : MaterialStateProperty.all(
                        Colors.grey[100],
                      ),
                    ),
                    label: Text(
                      "NSFW",
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    icon: Text(
                      "18",
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (controller.isPostSpoiler.value == false) {
                      controller.isPostSpoiler.value = true;
                      controller.isPostSpoiler.refresh();
                    } else {
                      controller.isPostSpoiler.value = false;
                      controller.isPostSpoiler.refresh();
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all(Size(122.0, 20.0)),
                    backgroundColor: (controller.isPostSpoiler.value)
                        ? MaterialStateProperty.all(
                      Colors.black87,
                    )
                        : MaterialStateProperty.all(
                      Colors.grey[100],
                    ),
                  ),
                  label: Text(
                    "Spoiler",
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  icon: Icon(
                    IconBroken.Danger,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Obx(()=>
                Visibility(
                  visible: (controller.flairsOfSubreddit.length>0)?true:false,
                  child: ListTile(
                    onTap: ()
                    {
                      Get.to(FlairList());
                    },
                    horizontalTitleGap: 0.0,
                    title:Text(controller.textOfFlair.isEmpty?"Add Flar":
                    controller.textOfFlair.value,
                      style: TextStyle(
                        color: controller.textColorOfFlair.value=="None"?
                        Colors.black87:
                        HexColor(controller.textColorOfFlair.value),
                        backgroundColor: controller.backgroundColorOfFlair.value=="None"?
                        Colors.white:
                        HexColor(controller.backgroundColorOfFlair.value),
                      ),
                    ),
                    // Text("Add flair"),
                    leading: Icon(IconBroken.Edit),
                    trailing: Icon(IconBroken.Arrow___Right_2),
                  ),
                ),
            ),
            const Divider(
              height: 10.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.flairsOfSubreddit.clear();
    super.dispose();
  }
}
