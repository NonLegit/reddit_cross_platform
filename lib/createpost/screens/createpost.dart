///////////////////////BY ME///////////////////////////////////////////
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
  final postController controller = Get.put(
    postController(),
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: const Icon(
                    Icons.close,
                    size: 32.0,
                  ),
                  color: Colors.black45,
                ),
                const Spacer(),
                Obx(
                  () => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : MaterialButton(
                            onPressed: () {
                              if (controller.postTitle.value.text != "") {
                                Get.to(buildSubreddit());
                              } else
                                return null;
                              // if (controller.formKey.currentState!.validate()) {
                              //   controller.createPost();
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Processing Data')),
                              //   );
                              //
                              // }
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
                ),
              ],
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: TextFormField(
                  onChanged: (value) {
                    controller.postTitle.refresh();
                  },
                  // validator: ((value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // }),
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(child: BuildFormType(controller: controller)),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, bottom: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.typeOfPost.value = "text";
                      },
                      icon: const Icon(IconBroken.Paper)),
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
            )
          ],
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
////////////////OLDDDDDDDDDDDDDDDDDDDDDDDDD///////////////////////////////////////////////

// class createPostScreen extends StatefulWidget {
//   const createPostScreen({Key? key}) : super(key: key);
//   @override
//   State<createPostScreen> createState() => _createPostScreenState();
// }

// class _createPostScreenState extends State<createPostScreen> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Function to detect the type of post
//     Widget f() {
//       // If the type is url or post return the TextFormField if video of image container
//       if (typeOfPost == "text") {
//         return TextFormField(
//           controller: textPost,
//           enabled: true,
//           style: TextStyle(fontSize: 14.0),
//           showCursor: true,
//           toolbarOptions: ToolbarOptions(copy: false, cut: false, paste: false),
//           keyboardType: TextInputType.multiline,
//           textInputAction: TextInputAction.newline,
//           autofocus: true,
//           maxLines: null,
//           textAlign: TextAlign.start,
//           decoration: InputDecoration(hintText: "Add optional body text", border: InputBorder.none
//               //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
//               ),
//         );
//       } else if (typeOfPost == "video") {
//         return Container();
//       } else if (typeOfPost == "url") {
//         return TextFormField(
//           controller: urlPost,
//           enabled: true,
//           style: TextStyle(fontSize: 14.0),
//           showCursor: true,
//           textAlign: TextAlign.start,
//           decoration: InputDecoration(hintText: "URL", border: InputBorder.none
//               //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
//               ),
//         );
//       } else if (typeOfPost == "image") {
//         return Container();
//       } else {
//         return Container();
//       }
//     }

//     return BlocProvider(
//       create: (BuildContext context) => layoutCubit(),
//       child: BlocConsumer<layoutCubit, layoutStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var cubit = layoutCubit.get(context);
//             return Scaffold(
//               backgroundColor: Colors.white,
//               body: Column(
//                 children: [
//                   SizedBox(height: 40.0),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           size: 32.0,
//                         ),
//                         color: Colors.black45,
//                       ),
//                       Spacer(),
//                       Padding(
//                         padding: const EdgeInsetsDirectional.only(end: 20.0),
//                         child: MaterialButton(
//                           onPressed: () {
//                             // layoutCubit.get(context).submitpost(title:"newPost",kind: "textpost",text: "wed",URL: "we",owner: "ec",ownerType: "saf",nsfw:false);
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => finalPostScreen()));
//                           },
//                           elevation: 0.0,
//                           height: 35.0,
//                           minWidth: 80.0,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                           color: colorOfMaterialButton,
//                           child: Text(
//                             "Next",
//                             style: TextStyle(
//                               color: Colors.grey[400],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsetsDirectional.only(start: 10.0),
//                       child: TextFormField(
//                         onChanged: (value) {
//                           print(value);
//                           setState(() {
//                             if (value.isEmpty) {
//                               colorOfMaterialButton = Colors.grey[100];
//                             } else {
//                               colorOfMaterialButton = Colors.blue[900];
//                               print("val is not empty");
//                               print(postTitle.text);
//                             }
//                           });
//                         },
//                         controller: postTitle,
//                         enabled: true,
//                         style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
//                         showCursor: true,
//                         textAlign: TextAlign.start,
//                         decoration: InputDecoration(hintText: "An interesting title", border: InputBorder.none
//                             //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
//                             ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Expanded(
//                     child: Padding(padding: const EdgeInsetsDirectional.only(start: 10.0), child: f()),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       setState(() {
//                         typeOfPost = "image";
//                       });
//                     },
//                     leading: Icon(IconBroken.Image_2),
//                     title: Text("Image"),
//                     horizontalTitleGap: 0.0,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       setState(() {
//                         typeOfPost = "video";
//                       });
//                     },
//                     leading: Icon(IconBroken.Video),
//                     title: Text("Video"),
//                     horizontalTitleGap: 0.0,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       setState(() {
//                         typeOfPost = "text";
//                       });
//                     },
//                     leading: Icon(IconBroken.Paper),
//                     title: Text("Text"),
//                     horizontalTitleGap: 0.0,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       setState(() {
//                         typeOfPost = "url";
//                       });
//                     },
//                     leading: Icon(IconBroken.Bookmark),
//                     title: Text("Link"),
//                     horizontalTitleGap: 0.0,
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
