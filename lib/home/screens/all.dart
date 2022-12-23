import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:post/home/widgets/buttom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../create_community/screens/create_community.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../createpost/screens/createpost.dart';
import '../../icons/icon_broken.dart';
import '../../post/widgets/post.dart';
import '../../post/widgets/post_list.dart';
import '../../widgets/loading_reddit.dart';
import '../controller/home_controller.dart';
import '../widgets/custom_upper_bar.dart';
import 'home_layout.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> with TickerProviderStateMixin {
  final HomeController controller = Get.put(
    HomeController(),
  );
  final PostController controllerForPost = Get.put(
    PostController(),
  );
  late AnimationController loadingSpinnerAnimationController;
  @override
  void initState() {
    super.initState();
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.allPosts.isEmpty) {
      controller.getPostsInAll(sort: controller.sortAllBy.value,p: controller.pageNumberAll.value);
    }
  }
  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double ScreenSizeWidth = MediaQuery.of(context).size.width;

    final isDesktop = ScreenSizeWidth >= 700;
    final isMobile = ScreenSizeWidth < 700;

    if (isDesktop) {
      return
        Obx(()=>
           Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(700, 60),
                child: UpBar(controller: controller, controllerForCreatePost: controllerForPost,)),
            backgroundColor: const Color(0xA2D4E4FA),
            body:
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 200),
                        child: Column(
                          children: [
                            SizedBox(height: 2,),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: 650,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Image.asset('assets/images/1.png'),
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  Container(
                                    width: 450.0,
                                    height: 35.0,
                                    color: const Color(0xA2F2F4F6),
                                    child: TextFormField(
                                      onTap: ()=>  Get.to(CreatePostSCreen()),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Create Post',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  IconButton(
                                    icon:Icon(Icons.photo),
                                    onPressed: () {
                                      Get.to(CreatePostSCreen(), arguments: [
                                        0, 0,
                                        0
                                      ]);
                                    },

                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                      onPressed: ()
                                      {
                                        Get.to(CreatePostSCreen(), arguments: [
                                          0, 0,
                                          0
                                        ]);
                                      },
                                      icon:Icon(Icons.insert_link)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: 650,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                        onPressed: () {
                                          controller.sortHomePostsBy.value="best";
                                          controller.sortHomePostsBy.update((val) { });
                                        },
                                        icon:  Icon( // <-- Icon
                                          Icons.add_alert_rounded,
                                          size: 15.0,
                                        ),
                                        label: Text('Best'), // <-- Text
                                      ),
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),

                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                    onPressed: () {
                                      controller.sortHomePostsBy.value="hot";
                                      controller.sortHomePostsBy.update((val) { });
                                    },
                                    icon: Icon( // <-- Icon
                                      Icons.fireplace,
                                      size: 15.0,
                                    ),
                                    label: Text('Hot'), // <-- Text
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(shape: StadiumBorder(),shadowColor: Colors.blue),
                                    onPressed: () {
                                      controller.sortHomePostsBy.value="new";
                                      controller.sortHomePostsBy.update((val) { });
                                    },
                                    icon: Icon( // <-- Icon
                                      Icons.new_releases_outlined,
                                      size: 15.0,
                                    ),
                                    label: Text('New'), // <-- Text
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                    onPressed: () {
                                      controller.sortHomePostsBy.value="top";
                                      controller.sortHomePostsBy.update((val) { });
                                    },
                                    icon: Icon( // <-- Icon
                                      Icons.topic,
                                      size: 15.0,
                                    ),
                                    label: Text('Top'), // <-- Text
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width:100 ,),
                      Container(
                        margin:EdgeInsetsDirectional.only(top: 100) ,
                        height: 300,
                        width: 350,
                        color: Colors.white,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Text("Your personal Reddit frontpage. Come here to check in with your favorite communities."),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(CreatePostSCreen(),arguments: [0,0,0]);
                                },
                                child: Text('     Create post     ',style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Colors.blue),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 300,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.to(CreateCommunity());
                                },
                                child: Text('Create Community',style: TextStyle(color: Colors.blue),),
                                style: OutlinedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  side: BorderSide(width: 2.0, color: Colors.blue),

                                ),
                              ),
                            )
                          ],),
                      )
                    ],
                  ),
                  RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.blue[900],
                    onRefresh: () async {
                      controller.allPosts.clear();
                      controller.pageNumberAll.value = 1;
                      controller.pageNumberAll.update((val) {});
                      controller.getPostsInAll(sort: controller.sortAllBy.value,p: controller.pageNumberAll.value);
                      controller.update();
                    },
                    child: controller.isLoading.value
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
                        ? Text("Unexpected Error Try Again..")
                        : controller.homePosts.isEmpty
                        ? LoadingReddit()
                    //const Text( "No Posts to show")
                        : PostList(
                      leftMargin: 200.0,
                      rightMargin: 650.0,
                      userName: '${controller.myProfile!.userName}',
                      updateData: ()
                      {
                        controller.pageNumberAll.value++;
                        controller.pageNumberAll.update((val) { });
                      },
                      data: controller.homePosts,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:FloatingActionButtonLocation.miniEndFloat ,
            floatingActionButton: Padding(
              padding: const EdgeInsetsDirectional.only(end: 320.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(HomeLayoutScreen());
                },
                child: Text('      Back to top     ',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Colors.blue),
              ),
            ),


          ),
        );
    }
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
            controller.pageNumberAll.update((val) {});
            controller.getPostsInAll(sort: controller.sortAllBy.value, p: controller.pageNumberAll.value);
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
            controller.getPostsInAll(sort: controller.sortAllBy.value,p: controller.pageNumberAll.value);
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
