import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/comments/widgets/comment.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../networks/const_endpoint_data.dart';
import '../../post/widgets/post.dart';
import '../../post/widgets/post_list.dart';
import '../../widgets/loading_reddit.dart';
import '../controller/home_controller.dart';

class SavedCommentView extends StatefulWidget {
  SavedCommentView({Key? key}) : super(key: key);

  @override
  State<SavedCommentView> createState() => _SavedCommentViewState();
}

class _SavedCommentViewState extends State<SavedCommentView> with TickerProviderStateMixin{
  final HomeController controller = Get.put(HomeController());
  late AnimationController loadingSpinnerAnimationController;
  @override
  void initState()
  {
    super.initState();
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.userSavedComments.isEmpty) {
      controller.getSavedComments(p: controller.pageNumberComment.value, );
    }
  }
  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Scaffold(
          body:
          RefreshIndicator(
            backgroundColor: Colors.white,
            color: Colors.blue[900],
            onRefresh: () async {
              controller.userSavedComments.clear();
              controller.pageNumberComment.value = 1;
              controller.pageNumberComment.update((val) {});
              controller.getSavedComments(p: controller.pageNumberComment.value, );
              controller.update();
              //Get.forceAppUpdate();
            },
            child: controller.isLoadingCommetns.value
                ? Center(
              child: CircularProgressIndicator(
                valueColor: loadingSpinnerAnimationController.drive(
                  ColorTween(
                    //begin: Colors.blueAccent,
                    end: Colors.blueAccent,
                  ),
                ),
              ),
            )
                : controller.errorComment.value
                ? ListView(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(150),
                  child: Text("Unexpected Error Try Again.."),
                ),
              ],
            )
                : controller.userSavedComments.isEmpty
                ? LoadingReddit()

            : ListView.builder(
                itemCount: controller.userSavedComments.length,
                itemBuilder: (
                  final BuildContext ctx,
                  final int index,
                ) {
                  return Comment(data:controller.userSavedComments[index], userName: '${controller.myProfile!.userName}'
                  );
                },
              ),
          )
        ),
    );
  }
}
