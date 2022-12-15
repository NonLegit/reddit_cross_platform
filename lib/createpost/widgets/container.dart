import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';
import '../controllers/posts_controllers.dart';
import '../screens/finalpost.dart';

class SubredditModeratorContainer extends StatelessWidget {
  // const SubredditContainer({Key? key}) : super(key: key);
  final PostController controller = Get.put(
    PostController(),
  );
  String nameOfSubreddit = "";
  String iconOfSubreddit = '';
  int memberCount = 0;
  SubredditModeratorContainer({
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
      subtitle: Text("$memberCount " + "members . " + "moderator"),
      onTap: () {
        controller.subredditToSubmitPost = RxString(nameOfSubreddit);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FinalPost()));
      },
    );
  }
}
