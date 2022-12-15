import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/createpost/controllers/posts_controllers.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/home/widgets/new_drawer.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/widgets/loading_reddit.dart';
import '../../icons/icon_broken.dart';
import '../../post/widgets/post.dart';
import '../widgets/buttom_nav_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/end_drawer.dart';
import '../controller/home_controller.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../widgets/recently_visited_list.dart';

class homeLayoutScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  State<homeLayoutScreen> createState() => _homeLayoutScreenState();
}

class _homeLayoutScreenState extends State<homeLayoutScreen> with TickerProviderStateMixin{
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

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        controller.getMorePosts();
      }
    });
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.homePosts.isEmpty) {
     controller.getPosts();
    }
  }
  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }
// for dropdown list
  String dropValue = "Home";
  // Lists for DropDown Menu at appBar
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
  //users/best?page=1&limit=20
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
            // To make style for status bar
            systemOverlayStyle: SystemUiOverlayStyle(
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
                print(
                    "posts in home list length :${controller.homePosts.length}");
                print(
                    "moderator list length :${controllerForPost.moderatedSubreddits.length}");
                print(
                    "modsub length ${controllerForPost.moderatedSubreddits.length}");
                print("name of ${controllerForPost.moderatedSubreddits[0]}");
              },
              icon: Text(
                "Home",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600),
              ),
              label: Icon(
                IconBroken.Arrow___Down_2,
                color: Colors.black,
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                fixedSize: MaterialStateProperty.all(Size(100.0, 20.0)),
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
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${controller.myProfile!.profilePicture}'),
                        radius: 30.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 6,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 2, bottom: 2),
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
        bottomNavigationBar: buttomNavBar(),
        endDrawer: endDrawer(controller: controller,),
        drawer: //RecentlyVisitedDrawer(controller: this.controller,),
            (controller.isRecentlyVisitedDrawer.value == true)
                ? RecentlyVisitedDrawer(
                    controller: this.controller,
                  )
                : MyDrawer(
                    controller: this.controller,
                    controllerForCreatePost: this.controllerForPost),
        body: RefreshIndicator(
          onRefresh: controller.getPosts,
          child:controller.isLoading.value
              ? Center(
            child:LoadingReddit(),
          )
              :controller.error.value
              ? ListView(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 150),
                child: Text("Unexpected Error Try Again.."),
              ),
            ],
          )
              :controller.homePosts.isEmpty
              ? const Text( "No Posts to show")
              : ListView.builder(
            controller: _controller,
            itemCount:controller.homePosts.length,
            itemBuilder: (
                final BuildContext ctx,
                final int index,
                ) {
              return  Post.home(
                            data: controller.homePosts[index],

              );
            },
          ),
        ),
        // body: (controller.homePosts.length > 0)
        //     ? RefreshIndicator(
        //       onRefresh: () async {
        //         controller.getPosts();
        //       },
        //       child: ListView.separated(
        //           itemBuilder: (BuildContext context, int index) => Post.home(
        //             data: controller.homePosts[index],
        //           ),
        //           separatorBuilder: (BuildContext context, int index) => SizedBox(
        //             height: 10,
        //           ),
        //           itemCount: controller.homePosts.length,
        //
        //       ),
        //     )
        //     : LoadingReddit()
        // Center(child: Text("No Posts to show"),)

        ));
  }
}
