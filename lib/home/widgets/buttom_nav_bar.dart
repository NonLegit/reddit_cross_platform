
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../createpost/screens/createpost.dart';
import '../../notification/screens/notifications_screen.dart';
import '../../icons/icon_broken.dart';
import '../screens/home_layout.dart';
import '../../discover/screens/discover_screen.dart';
class buttomNavBar extends StatefulWidget {
  const buttomNavBar({
  //required this.fromProfile
  Key? key}) : super(key: key);
 //final int fromProfile;
  @override
  State<buttomNavBar> createState() => _buttomNavBarState();
}

class _buttomNavBarState extends State<buttomNavBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      color: Colors.black,
       // color: Colors.grey[600], // unselected icon color
        //activeColor: Colors.black, // selected icon and text color
        iconSize: 28, // tab button icon size
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // navigation bar paddin
         backgroundColor: Colors.white,
        onTabChange: (index) {
          setState(() {
            switch (index) {
              case 0:
                {
                  print("index = $index");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => homeLayoutScreen()));
                }
                break;
              case 1:
                {
                  print("index = $index");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiscoverScreen()));

                }
                break;
              case 2:
                {
                  print("index = $index");
                //  Get.to(CreatePostSCreen(),arguments: [widget.fromProfile]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:
                              (context) => CreatePostSCreen()));

                }
                break ;
              case 3:
                {
                  print("index = $index");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => chatScreen()));

                }
                break;
              case 4:
                {
                  print("index = $index");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));

                }
                break;
            }
          },
          );
        },
        tabs:
        const[
          GButton(icon: Icons.home,),
          GButton(icon:IconBroken.Discovery),
          GButton(icon: Icons.add,),
          GButton(icon: IconBroken.Chat,),
          GButton(icon: IconBroken.Notification,)
        ]
    );
  }
}
