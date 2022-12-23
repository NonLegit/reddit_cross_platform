import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../post/widgets/post.dart';
import '../../post/widgets/post_list.dart';
import '../../widgets/loading_reddit.dart';
import '../controller/home_controller.dart';

class SavedPosts extends StatefulWidget {
   SavedPosts({Key? key}) : super(key: key);

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> with TickerProviderStateMixin{
  final HomeController controller = Get.put(HomeController());
  late AnimationController loadingSpinnerAnimationController;
  @override
  void initState()
  {
    super.initState();
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.userSavedPosts.isEmpty) {
      controller.getSavedPosts(p: controller.pageNumberSaved.value, );
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
             controller.userSavedPosts.clear();
             controller.pageNumberSaved.value = 1;
             controller.pageNumberSaved.update((val) {});
             controller.getSavedPosts(p: controller.pageNumberSaved.value,);
             controller.update();
             //Get.forceAppUpdate();
           },
           child: controller.isLoadingSaved.value
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
               : controller.errorSaved.value
               ? ListView(
             children: const <Widget>[
               Padding(
                 padding: EdgeInsets.all(150),
                 child: Text("Unexpected Error Try Again.."),
               ),
             ],
           )
               : controller.userSavedPosts.isEmpty
               ? LoadingReddit()
               :
           PostList(
             userName: '${controller.myProfile!.userName}', updateData: (){
             controller.pageNumberSaved.value++;
             controller.pageNumberSaved.update((val) { });
             controller.getSavedPosts(p: controller.pageNumberSaved.value,);
           }, data: controller.userSavedPosts,
           ),
         ) ,

      ),
    );
  }
}
