import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../createpost/screens/createpost.dart';
import '../../notification/screens/notifications_screen.dart';
import '../../icons/icon_broken.dart';
import '../controller/home_controller.dart';
import '../screens/home_layout.dart';

class buttomNavBar extends StatefulWidget {
  const buttomNavBar(
      {required this.fromProfile,
      required this.icon,
      required this.nameOfSubreddit,
      required this.x,
      Key? key})
      : super(key: key);
  final int fromProfile;
  final String icon;
  final String nameOfSubreddit;
  final int x;
  @override
  State<buttomNavBar> createState() => _buttomNavBarState();
}

class _buttomNavBarState extends State<buttomNavBar> {
  get x => null;

  @override
  Widget build(BuildContext context) {
    return GNav(
        color: Colors.black,
        // color: Colors.grey[600], // unselected icon color
        //activeColor: Colors.black, // selected icon and text color
        iconSize: 28, // tab button icon size
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 15), // navigation bar paddin
        backgroundColor: Colors.white,
        onTabChange: (index) {
          setState(
            () {
              switch (index) {
                case 0:
                  {
                    // if (x == 0) {
                    //   Get.find<HomeController>().myScroll.animateTo(0,
                    //       duration: Duration(seconds: 2),
                    //       curve: Curves.easeOut);
                    // } else {
                      Get.to(HomeLayoutScreen());
                    //}
                  }
                  break;
                case 1:
                  {
                    Get.to(HomeLayoutScreen());
                  }
                  break;
                case 2:
                  {
                    print("index = $index");
                    Get.to(CreatePostSCreen(), arguments: [
                      widget.fromProfile,
                      widget.icon,
                      widget.nameOfSubreddit
                    ]);
                  }
                  break;
                case 3:
                  {
                    Get.to(HomeLayoutScreen());
                  }
                  break;
                case 4:
                  {
                    Get.to(NotificationScreen());
                  }
                  break;
              }
            },
          );
        },
        tabs: const [
          GButton(
            icon: Icons.home,
          ),
          GButton(icon: IconBroken.Discovery),
          GButton(
            icon: Icons.add,
          ),
          GButton(
            icon: IconBroken.Chat,
          ),
          GButton(
            icon: IconBroken.Notification,
          )
        ]);
  }
}
