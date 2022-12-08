////////////BY ME//////////////////
import 'dart:io';

// import 'package:developerversion/createpost/widgets/video_photo_container.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../controllers/posts_controllers.dart';

class BuildFormType extends StatelessWidget {
  const BuildFormType({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PostController controller ;

  @override
  Widget build(BuildContext context) {
   return Obx(
     ()=> (
         Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: controller.typeOfPost.value == "url"
                ?  TextFormField(
                      validator: (value){
                        String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                        RegExp regExp = new RegExp(pattern);
                        if (value!.length == 0) {
                          return 'Please enter url';
                        }
                        else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid url';
                        }
                        return null;
                      },
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
                        :  ListView.separated(
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
                                      File(controller.imageFileList![index].path),
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

                    : (controller.typeOfPost == "video")
                        ?SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: VideoPlayer(
                        controller.videoController.value!
                      )),
                  IconButton(
                      onPressed: () {
                       controller.playVideo();
                      },
                      icon: (controller.videoController.value!.value.isPlaying)? Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30,
                      ): Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                  )
                ],
              ),
            )

                        : SizedBox()

         )
     )
   );
  }
}
