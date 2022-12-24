import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/create_community/screens/create_community.dart';
import 'package:post/createpost/screens/createpost.dart';
import 'package:post/logins/screens/login.dart';
import 'package:post/notification/screens/notifications_screen.dart';
import 'package:post/settings/screens/settings.dart';
import '../../logins/providers/authentication.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../icons/icon_broken.dart';
import '../../logins/providers/authentication.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../search/screens/search.dart';
import '../controller/home_controller.dart';
import '../screens/all.dart';
import '../screens/home_layout.dart';
import 'community_container.dart';

class UpBar extends StatelessWidget {
  final HomeController controller;
  final PostController controllerForCreatePost;
  UpBar({
    Key? key,
    required this.controller,
    required this.controllerForCreatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
          child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Image.asset('assets/images/redditlogo.png'),
      )),
      title: Row(
        children: [
          const Text(
            'Reddit',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
              width: 220,
              child: PopupMenuButton<int>(
                child: Row(
                  children: [
                    Icon(Icons.home_filled),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Home"),
                    SizedBox(
                      width: 80,
                    ),
                    Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
                elevation: 0,
                color: Colors.white,
                offset: Offset(0, 43),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Container(
                        width: 220,
                        child: Text(
                          "MODERATING",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Container(
                        width: 220,
                        child: Column(
                          children: List.generate(
                              controllerForCreatePost
                                  .moderatedSubreddits.length,
                              (index) => CommunityContainer(
                                  nameOfSubreddit: controllerForCreatePost
                                      .moderatedSubreddits[index]
                                      .subredditName!,
                                  iconOfSubreddit: (controllerForCreatePost
                                              .moderatedSubreddits[index]
                                              .icon !=
                                          null)
                                      ? controllerForCreatePost
                                          .moderatedSubreddits[index].icon!
                                      : '')),
                        )),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Container(
                        width: 220,
                        child: Text(
                          "YOUR COMMUNITIES",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: ListTile(
                      onTap: () {
                        Get.to(CreateCommunity());
                      },
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      title: Text(
                        "Create Community",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Container(
                        width: 220,
                        child: Column(
                          children: List.generate(
                              controllerForCreatePost
                                  .subscribedSubreddits.length,
                              (index) => CommunityContainer(
                                  nameOfSubreddit: controllerForCreatePost
                                      .subscribedSubreddits[index]
                                      .subredditName!,
                                  iconOfSubreddit: (controllerForCreatePost
                                              .subscribedSubreddits[index]
                                              .icon !=
                                          null)
                                      ? controllerForCreatePost
                                          .subscribedSubreddits[index].icon!
                                      : '')),
                        )),
                  ),
                  PopupMenuItem(
                    value: 6,
                    child: Container(
                        width: 220,
                        child: Text(
                          "FEEDS",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )),
                  ),
                  PopupMenuItem(
                      value: 7,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(HomeLayoutScreen());
                            },
                            horizontalTitleGap: 0,
                            leading: Icon(Icons.home_filled),
                            title: Text("Home"),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(All());
                            },
                            horizontalTitleGap: 0,
                            leading: Icon(Icons.stacked_bar_chart),
                            title: Text("All"),
                          )
                        ],
                      )),
                ],
              )),
          Expanded(
            child: Container(
              width: 350.0,
              height: 35.0,
              child: TextFormField(
                onTap: () {
                  Get.to(Search());
                },
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Search Reddit',
                  prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                Get.to(All());
              },
              icon: const Icon(
                Icons.arrow_circle_up,
                size: 25,
              )),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                Get.to(NotificationScreen());
              },
              icon: const Icon(
                IconBroken.Notification,
                size: 25,
              )),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                Get.to(CreatePostSCreen(), arguments: [0, 0, 0]);
              },
              icon: const Icon(
                Icons.add_sharp,
                size: 25,
              )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      actions: [
        Container(
          padding: EdgeInsetsDirectional.only(end: 20, start: 10),
          child: PopupMenuButton<int>(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 0.25)),
              width: 270,
              height: 20,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: const [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/reddit.gif"),
                          radius: 18.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: 2, bottom: 2),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 4,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Ahmed"),
                          Text("karma"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    const Icon(IconBroken.Arrow___Down_2)
                  ],
                ),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Container(
                  padding: EdgeInsetsDirectional.only(end: 80),
                  height: 40,
                  width: 220,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(
                      IconBroken.Profile,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "My Stuff",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Container(
                  padding: EdgeInsetsDirectional.only(start: 30, bottom: 10),
                  height: 30,
                  width: 220,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(MyProfileScreen.routeName,
                          arguments: controller.myProfile!.userName);
                      // Get.to(MyProfileScreen,
                      //     arguments: controller.myProfile!.userName);
                    },
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Container(
                  padding: EdgeInsetsDirectional.only(start: 30, bottom: 10),
                  height: 30,
                  width: 220,
                  child: ListTile(
                    onTap: () {
                      Get.to(Settings());
                    },
                    title: Text(
                      "User settings",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(child: Divider()),
              PopupMenuItem(
                value: 4,
                child: Container(
                  padding: EdgeInsetsDirectional.only(end: 0),
                  height: 40,
                  width: 220,
                  child: ListTile(
                    onTap: () {
                      Get.to(CreateCommunity());
                    },
                    horizontalTitleGap: 0,
                    leading: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 12.0),
                      child: Icon(
                        Icons.r_mobiledata_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      "Create a Community",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: Container(
                  padding: EdgeInsetsDirectional.only(start: 40),
                  height: 40,
                  width: 220,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(child: Divider()),
              PopupMenuItem(
                value: 6,
                child: Container(
                  padding: EdgeInsetsDirectional.only(start: 10, bottom: 1),
                  height: 30,
                  width: 220,
                  child: ListTile(
                    onTap: () {
                      Auth().logOut(context);
                      Navigator.of(context).pushNamed(Login.routeName);
                    },
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(child: Divider()),
            ],
            offset: Offset(0, 59),
            color: Colors.white,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
