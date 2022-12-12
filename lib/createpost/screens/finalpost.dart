import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../home/screens/home_layout.dart';
import '../../icons/icon_broken.dart';
import '../controllers/posts_controllers.dart';
import './schedulepost.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinalPost extends StatelessWidget {
  // const FinalPost({Key? key}) : super(key: key);
  final PostController controller = Get.put(
    PostController(),
  );
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
                      child: Icon(
                        IconBroken.Arrow___Left_2,
                        size: 32.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 250.0,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 1.w),
                      child: MaterialButton(
                        onPressed: () {
                          controller.sendPost(context);
                          controller.postTitle.value.clear();
                          controller.urlPost.value.clear();
                          controller.textPost.value.clear();
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homeLayoutScreen()));
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
                            backgroundColor: Colors.blue,
                            radius: 20.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
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
                ListTile(
                  horizontalTitleGap: 0.0,
                  title: Text("Add flair"),
                  leading: Icon(IconBroken.Edit),
                  trailing: Icon(IconBroken.Arrow___Right_2),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => schedulePostScreen()));
                  },
                  horizontalTitleGap: 0.0,
                  title: Text("Schedule Post"),
                  leading: Icon(Icons.access_time_outlined),
                  trailing: Icon(IconBroken.Arrow___Right_2),
                ),
              ],
            ),
          ),
        ));
  }
}
