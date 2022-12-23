import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/create_community/screens/create_community.dart';
import 'package:post/createpost/controllers/posts_controllers.dart';
import 'package:post/createpost/screens/createpost.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/home/widgets/community_container.dart';
import 'package:post/home/widgets/new_drawer.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/widgets/loading_reddit.dart';
import '../../icons/icon_broken.dart';
import '../../post/widgets/post.dart';
import '../../post/widgets/post_list.dart';
import '../widgets/buttom_nav_bar.dart';
import '../widgets/custom_upper_bar.dart';
import '../widgets/end_drawer.dart';
import '../controller/home_controller.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../widgets/recently_visited_list.dart';

class HomeLayoutScreen extends StatefulWidget {
  static const routeName = '/homepage';
  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen>
    with TickerProviderStateMixin {
  final HomeController controller = Get.put(
    HomeController(),
  );
  final PostController controllerForPost = Get.put(
    PostController(),
  );

// Value for DropDownButton
  String dropDownButtonValue = "Home";
  List<String> list = ["Home", "Popular"];
  // Icons when expansionlist at the drawer
  dynamic icRecent = Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating = Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities = Icon(IconBroken.Arrow___Right_2);
  // bools to handle the Expansion pannels in drawer
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  //Unique  KEYS to handle the scaffold and form and drawer
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var drawerKey = GlobalKey<DrawerControllerState>();
  // drawer functions
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  late AnimationController loadingSpinnerAnimationController;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // controller.myScroll.addListener(() {
    //   if (controller.myScroll.position.pixels >=
    //       controller.myScroll.position.maxScrollExtent - 50) {
    //     controller.pageNumber.value++;
    //     controller.getPosts();
    //   }
    // });
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.homePosts.isEmpty) {
      controller.getPosts(sort: controller.sortHomePostsBy.value,p: controller.pageNumber.value);
    }
  }

  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }



// for dropdown list
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
        child: ButtonBar(
          children: [Text("Home")],
        )),
    DropdownMenuItem(
        child: ButtonBar(
          children: [Text("Popular")],
        ))
  ];

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
            body:SingleChildScrollView(
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
                      controller.homePosts.clear();
                      controller.pageNumber.value = 1;
                      controller.pageNumber.update((val) {});
                      controller.getPosts(sort: controller.sortHomePostsBy.value,p: controller.pageNumber.value);
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
                        controller.pageNumber.value++;
                        controller.pageNumber.update((val) { });
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
    return Obx(
          () => Scaffold(
        appBar: AppBar(
          // To make style for status bar
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () => showDrawer(context),
                icon: Icon(Icons.menu_rounded, color: Colors.black, size: 30),
              );
            }),
            title: ElevatedButton.icon(
              onPressed: () {
                // controller.sortHomePostsBy.value = "top";
                // controller.sortHomePostsBy.update((val) {});
                // controller.pageNumber.value = 1;
                // controller.getPosts();
                print(
                    "LIST length ${controller.homePosts.length} and page num ${controller.pageNumber.value}");
                print(
                    "posts in home list length :${controller.homePosts.length}");
                print(
                    "moderator list length :${controllerForPost.moderatedSubreddits.length}");
                print(
                    "modsub length ${controllerForPost.moderatedSubreddits.length}");
                print("name of ${controllerForPost.moderatedSubreddits[0]}");
              },
              icon: const Text(
                "Home",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600),
              ),
              label: const Icon(
                IconBroken.Arrow___Down_2,
                color: Colors.black,
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                fixedSize: MaterialStateProperty.all(const Size(100.0, 20.0)),
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Search,
                  color: Colors.black87,
                  size: 28.0,
                ),
              ),
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () => showEndDrawer(context),
                  icon: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      // (controller.myProfile!.profilePicture == "")
                      //     ? Image.asset('assets/images/loadingreddit.gif')
                      //     : CircleAvatar(
                      //         backgroundImage: NetworkImage(
                      //             "${controller.myProfile!.profilePicture}"),
                      //         radius: 30.0,
                      //       ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 6,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 2, bottom: 2),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 4,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ]),
        bottomNavigationBar: const buttomNavBar(
          fromProfile: 0,
          icon: '',
          nameOfSubreddit: '',
          x: 0,
        ),
        endDrawer: endDrawer(
          controller: controller,
        ),
        drawer: //RecentlyVisitedDrawer(controller: this.controller,),
        (controller.isRecentlyVisitedDrawer.value == true)
            ? RecentlyVisitedDrawer(
          controller: this.controller,
        )
            : MyDrawer(
            controller: this.controller,
            controllerForCreatePost: this.controllerForPost),
        body: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue[900],
          onRefresh: () async {
            controller.homePosts.clear();
            controller.pageNumber.value = 1;
            controller.pageNumber.update((val) {});
            controller.getPosts(sort: controller.sortHomePostsBy.value,p: controller.pageNumber.value);
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
              ? ListView(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(150),
                child: Text("Unexpected Error Try Again.."),
              ),
            ],
          )
              : controller.homePosts.isEmpty
              ? LoadingReddit()
          //const Text( "No Posts to show")
              : PostList(
            userName: '${controller.myProfile!.userName}',
            updateData: ()
            {
              controller.pageNumber.value++;
              controller.getPosts(sort: controller.sortHomePostsBy.value,p: controller.pageNumber.value);
            },
            data: controller.homePosts,
          ),
        ),
      ),
    );
  }
}
