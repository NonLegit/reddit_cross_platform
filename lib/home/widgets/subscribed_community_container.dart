import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/subreddit/screens/subreddit_screen.dart';

import '../../create_community/screens/create_community.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
class SubScribedCommunityContainer extends StatelessWidget {

  String nameOfSubreddit="";
  String iconOfSubreddit='';
  SubScribedCommunityContainer(
      {
        required this.nameOfSubreddit,
        required this.iconOfSubreddit,
      }
      );
  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 0.0,
        leading: CircleAvatar(radius: 13,backgroundColor: Colors.blue,
          backgroundImage: NetworkImage(
              "$iconOfSubreddit"
          ),
        ),
        title: Text("$nameOfSubreddit"),
        onTap: () {
          Get.to(SubredditScreen(), arguments: nameOfSubreddit);
        }

    );
  }
}
