import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:post/home/widgets/buttom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../icons/icon_broken.dart';
import '../../post/widgets/post.dart';
import '../../post/widgets/post_list.dart';
import '../../widgets/loading_reddit.dart';
import '../controller/home_controller.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> with TickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());
  late AnimationController loadingSpinnerAnimationController;
  @override
  void initState() {
    super.initState();
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.allPosts.isEmpty) {
      controller.getPostsInAll();
    }
  }
  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Obx(()=> Scaffold(
          bottomNavigationBar: const buttomNavBar(
            fromProfile: 0,
            icon: '',
            nameOfSubreddit: '', x: 1,
          ),
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text(
              "All",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          body:
           RefreshIndicator(
             backgroundColor: Colors.white,
             color: Colors.blue[900],
             onRefresh: () async {
               controller.allPosts.clear();
               controller.pageNumberAll.value = 1;
               controller.pageNumber.update((val) {});
               controller.getPostsInAll();
               controller.update();
             },
             child: controller.isLoadingAll.value
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
                 : controller.error.value
                 ? ListView(
               children: const <Widget>[
                 Padding(
                   padding: EdgeInsets.all(150),
                   child: Text("Unexpected Error Try Again.."),
                 ),
               ],
             )
                 : controller.allPosts.isEmpty
                 ? LoadingReddit()
             :
             PostList(
               userName: '${controller.myProfile!.userName}', updateData: (){
               controller.pageNumberAll.value++;
               controller.pageNumberAll.update((val) { });
               controller.getPostsInAll();
             }, data: controller.allPosts,
                   topOfTheList:
                     Padding(
                       padding: const EdgeInsetsDirectional.only(start: 15, top: 5),
                       child: Row(
                         children: [
                           Icon(
                             controller.allIcon.value,
                             color: Colors.grey,
                             size: 20,
                           ),
                           ElevatedButton.icon(
                             onPressed: () {
                               showModalBottomSheet(
                                   backgroundColor: Colors.transparent,
                                   context: context,
                                   builder: (context) => GestureDetector(
                                     onTap: () {},
                                     child: Container(
                                       padding: const EdgeInsets.all(30),
                                       height: 30.h,
                                       width: 30.w,
                                       margin: const EdgeInsets.all(5),
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5),
                                           color: Colors.white),
                                       child: Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.start,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         mainAxisSize: MainAxisSize.min,
                                         children: <Widget>[
                                           const Text('SORT POSTS BY',
                                               style: TextStyle(
                                                 color: Colors.grey,
                                               )),
                                           const Divider(
                                             height: 5,
                                           ),
                                           ListTile(
                                             onTap: () {
                                               controller.sortAllBy.value = "hot";
                                               controller.allIcon.value = Icons
                                                   .local_fire_department_rounded;
                                               controller.sortHistoryBy.update((val) { });
                                               Get.back();
                                               //   Get.forceAppUpdate();

                                             },
                                             leading: Icon(
                                                 Icons
                                                     .local_fire_department_rounded,
                                                 color:
                                                 (controller.sortAllBy.value ==
                                                     "hot")
                                                     ? Colors.black
                                                     : Colors.grey[500]),
                                             title: Text(
                                               "Hot",
                                               style: TextStyle(
                                                   color: (controller
                                                       .sortAllBy.value ==
                                                       "hot")
                                                       ? Colors.black
                                                       : Colors.grey[500]),
                                             ),
                                             trailing:
                                             (controller.sortAllBy.value ==
                                                 "hot")
                                                 ? Icon(
                                               Icons.done,
                                               color: Colors.green,
                                             )
                                                 : null,
                                           ),
                                           ListTile(
                                             onTap: () {
                                               controller.sortAllBy.value = "new";
                                               controller.allIcon.value =
                                                   Icons.brightness_low;
                                               controller.sortHistoryBy.update((val) { });
                                               Get.back();
                                               //   Get.forceAppUpdate();

                                             },
                                             leading: Icon(Icons.brightness_low,
                                                 color:
                                                 (controller.sortAllBy.value ==
                                                     "new")
                                                     ? Colors.black
                                                     : Colors.grey[500]),
                                             title: Text(
                                               "New",
                                               style: TextStyle(
                                                   color: (controller
                                                       .sortAllBy.value ==
                                                       "new")
                                                       ? Colors.black
                                                       : Colors.grey[500]),
                                             ),
                                             trailing:
                                             (controller.sortAllBy.value ==
                                                 "new")
                                                 ? Icon(
                                               Icons.done,
                                               color: Colors.green,
                                             )
                                                 : null,
                                           ),
                                           ListTile(
                                             onTap: () {
                                               controller.sortAllBy.value = "top";
                                               controller.allIcon.value =
                                                   Icons.turn_sharp_right_sharp;
                                               controller.sortHistoryBy.update((val) { });
                                               Get.back();
                                               //   Get.forceAppUpdate();

                                             },
                                             leading: Icon(
                                                 Icons.turn_sharp_right_sharp,
                                                 color:
                                                 (controller.sortAllBy.value ==
                                                     "top")
                                                     ? Colors.black
                                                     : Colors.grey[500]),
                                             title: Text(
                                               "Top",
                                               style: TextStyle(
                                                   color: (controller
                                                       .sortAllBy.value ==
                                                       "top")
                                                       ? Colors.black
                                                       : Colors.grey[500]),
                                             ),
                                             trailing:
                                             (controller.sortAllBy.value ==
                                                 "top")
                                                 ? Icon(
                                               Icons.done,
                                               color: Colors.green,
                                             )
                                                 : null,
                                           ),
                                         ],
                                       ),
                                     ),
                                   ));
                             },
                             icon: Text(
                               "${controller.sortAllBy.value.toUpperCase()}",
                               style: const TextStyle(color: Colors.grey),
                             ),
                             label: const Icon(
                               IconBroken.Arrow___Down_2,
                               color: Colors.grey,
                               size: 15,
                             ),
                             style: ButtonStyle(
                               elevation: MaterialStateProperty.all<double>(0),
                               backgroundColor:
                               MaterialStateProperty.all(Colors.grey[300]),
                             ),
                           ),
                         ],
                       ),
                     ),
               ),
           ),


    ),
       );
  }
}
