import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/home/widgets/community_container.dart';
import 'package:post/home/widgets/subscribed_community_container.dart';
import 'package:post/networks/const_endpoint_data.dart';

import '../../create_community/screens/create_community.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../icons/icon_broken.dart';
import 'container_in_recently_visited.dart';

class RecentlyVisitedDrawer extends StatelessWidget {

  final HomeController controller;
  const RecentlyVisitedDrawer({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Divider(
              height: 3,
            ),
            Row(
                  children: [
                    IconButton(onPressed: (){
                      controller.isRecentlyVisitedDrawer.value=false;
                    }, icon: Icon(IconBroken.Arrow___Left_2)),
                    SizedBox(width: 5,),
                    Text(
                      "Recently Visited",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: (){
                      controller.recentlyVisited.clear();
                    }, child:
                    Text("Clear all",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    ),
                    )
                    ),
                  ],
              ),
            SizedBox(height: 8,),
           Column(
            children:
            List.generate(4, (index) =>
            RecentlyVisitedContainer(nameOfSubreddit: "coross", iconOfSubreddit: "https://png.pngtree.com/element_our/20190530/ourmid/pngtree-correct-icon-image_1267804.jpg")
            )
           )
          ],
        ),
      ),
    );
  }
}
