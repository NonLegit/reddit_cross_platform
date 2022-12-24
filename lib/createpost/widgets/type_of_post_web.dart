import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:video_player/video_player.dart';
import '../../createpost/controllers/posts_controllers.dart';

class BuildFormTypeWeb extends StatelessWidget {
  BuildFormTypeWeb({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PostController controller;
  @override
  Widget build(BuildContext context) {

    return Obx(
          () => Form(
        key: controller.formKeyUrl,
        child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: controller.typeOfPost.value == "link"
                ? Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: Container(
                width: 1000,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),

                child: TextFormField(
                  keyboardType: TextInputType.url,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(
                  //       RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$'))
                  // ],
                  onChanged: (value) {
                    controller.urlPost.refresh();
                  },
                  validator: (value) {
                    // String pattern =
                    //     r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
                    RegExp regExp = RegExp(
                        "((http|https)://)(www.)?[a-zA-Z0-9@:%._\\+~#?&//=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%._\\+~#?&//=]*)");
                    if (value!.isEmpty) {
                      return "Please enter your website";
                    } else if (!(regExp.hasMatch(value))) {
                      return "Website Url must be started from www";
                    } else {
                      return null;
                    }
                  },
                  controller: controller.urlPost.value,
                  enabled: true,
                  style: const TextStyle(fontSize: 14.0),
                  showCursor: true,
                  cursorColor: Colors.blue,
                  cursorHeight: 20.0,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, cut: true, paste: true),
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                      hintText: "URL", border: InputBorder.none
                    //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
                  ),
                ),
              ),
            )
                : controller.typeOfPost.value == "image"
                ? (controller.imageFileList!.length == 0)
                ? SizedBox()
                : Container(
              width: 1000,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),

              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, index) =>
                const SizedBox(
                  width: 20,
                ),
                itemBuilder: (BuildContext context, index) =>
                    SizedBox(
                      height: 250,
                      width: 120,
                      child: Stack(
                        //alignment: AlignmentDirectional.topEnd,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 100,
                          ),
                          Container(
                              width: 100,
                              height: 150,
                              child: Image.file(
                                File(controller
                                    .imageFileList![index].path),
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            top: -20,
                            right: -15,
                            child: IconButton(
                                onPressed: () {
                                  controller.imageFileList!
                                      .removeAt(index);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                        ],
                      ),
                    ),
                itemCount: controller.imageFileList!.length,
              ),
            )
                : (controller.typeOfPost == "video")
                ? (controller.videoController.value != null)
                ? Container(
              width: 1000,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),

              child: FutureBuilder(
                future: controller.initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: controller.videoController
                          .value!.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: Stack(
                          alignment:
                          AlignmentDirectional.topEnd,
                          children: [
                            Stack(
                              children: [
                                VideoPlayer(controller
                                    .videoController.value!),
                                Center(
                                  child: IconButton(
                                    onPressed: () {
                                      controller.playVideo();
                                    },
                                    icon: controller
                                        .videoController
                                        .value!
                                        .value
                                        .isPlaying
                                        ? const Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                        : const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            IconButton(onPressed: (){
                              controller.videoFile.value=null;
                              controller.videoController.value=null;
                            }, icon: Icon(Icons.close))
                          ]),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                },
              ),
            )
                : SizedBox()
                : (controller.typeOfPost == "self")
                ? Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 10.0),
                child: Container(
                  width: 1000,
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      quill.QuillToolbar.basic(
                        multiRowsDisplay: true,
                        controller: controller.textPost.value,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: quill.QuillEditor(
                            customStyles: quill.DefaultStyles(
                                color: Colors.red),
                            showCursor: true,
                            paintCursorAboveText: true,
                            focusNode: FocusNode(),
                            scrollController: ScrollController(),
                            scrollable: true,
                            padding: EdgeInsetsDirectional.only(
                                start: 10.0),
                            autoFocus: true,
                            expands: true,
                            controller: controller.textPost.value,
                            readOnly: false,
                          ),
                        ),
                      )
                    ],
                  ),
                )

              // child: TextFormField(
              //   controller: controller.textPost.value,
              //   enabled: true,
              //   style: const TextStyle(fontSize: 16.0),
              //   showCursor: true,
              //   cursorColor: Colors.blue,
              //   cursorHeight: 20.0,
              //   toolbarOptions:
              //   const ToolbarOptions(copy: true, cut: true, paste: true),
              //   keyboardType: TextInputType.multiline,
              //   textInputAction: TextInputAction.newline,
              //   autofocus: true,
              //   maxLines: null,
              //   textAlign: TextAlign.start,
              //   decoration: const InputDecoration(
              //       hintText: "Add optional body text",
              //       border: InputBorder.none),
              // ),
            )
                : SizedBox()),
      ),
    );
  }
}
