////////////BY ME//////////////////
import 'dart:io';

// import 'package:developerversion/createpost/widgets/video_photo_container.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/posts_controllers.dart';

class BuildFormType extends StatelessWidget {
  const BuildFormType({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final postController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: controller.typeOfPost.value == "text"
              ? TextFormField(
                  controller: controller.textPost.value,
                  enabled: true,
                  style: const TextStyle(fontSize: 14.0),
                  showCursor: true,
                  toolbarOptions:
                      const ToolbarOptions(copy: true, cut: true, paste: true),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  autofocus: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                      hintText: "Add optional body text",
                      border: InputBorder.none),
                )
              : controller.typeOfPost.value == "url"
                  ? TextFormField(
                      controller: controller.urlPost.value,
                      enabled: true,
                      style: const TextStyle(fontSize: 14.0),
                      showCursor: true,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          hintText: "URL", border: InputBorder.none
                          //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
                          ),
                    )
                  : controller.typeOfPost.value == "image"
                      ? (controller.imageFileList!.length == 0)
                          ? SizedBox()
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (BuildContext context, index) =>
                                  const SizedBox(
                                width: 20,
                              ),
                              itemBuilder: (BuildContext context, index) =>
                                  SizedBox(
                                height: 500,
                                width: 100,
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                        child: Image.file(
                                      File(controller
                                          .imageFileList![index].path),
                                      fit: BoxFit.fill,
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          controller.imageFileList!
                                              .removeAt(index);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 30,
                                        ))
                                  ],
                                ),
                              ),
                              itemCount: controller.imageFileList!.length,
                            )
                      : SizedBox()),
    );
  }
}
