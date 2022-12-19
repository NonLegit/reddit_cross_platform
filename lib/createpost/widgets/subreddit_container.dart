import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import '../controllers/posts_controllers.dart';
import '../screens/createpost.dart';
import '../screens/finalpost.dart';

class SubredditSubscriberContainer extends StatelessWidget {
  final PostController controller = Get.put(
    PostController(),
  );
  String nameOfSubreddit = "";
  String iconOfSubreddit = '';
  int memberCount = 0;
  SubredditSubscriberContainer({
    required this.nameOfSubreddit,
    required this.iconOfSubreddit,
    required this.memberCount,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.blue,
        backgroundImage: NetworkImage("$iconOfSubreddit"),
      ),
      title: Text("$nameOfSubreddit"),
      subtitle: Text("$memberCount " + "members . " + "subscribed"),
      onTap: () {
        controller.subredditToSubmitPost = RxString(nameOfSubreddit);
        controller.getFlairsOfSubreddit();
        if(controller.isFromHomeDirect.value==true)
        {
          Get.to(FinalPost());
        }
        else
        {
          Get.to(CreatePostSCreen(),arguments: [1,"${iconOfSubreddit}","${nameOfSubreddit}"]);
        }
      },
    );
  }
}
