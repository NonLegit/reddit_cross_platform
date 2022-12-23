import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/createpost/screens/createpost.dart';
import '../controllers/posts_controllers.dart';
import '../screens/finalpost.dart';

class WebContainer extends StatelessWidget {
  // const SubredditContainer({Key? key}) : super(key: key);
  final PostController controller = Get.put(
    PostController(),
  );
  String nameOfSubreddit = "";
  String iconOfSubreddit = '';
  String idOfSubreddit = '';
  WebContainer({
    required this.nameOfSubreddit,
    required this.iconOfSubreddit,
    required this.idOfSubreddit,
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
      onTap: () {
        controller.subredditToSubmitPost = RxString(nameOfSubreddit);
        controller.iconOfSubredditToSubmittPost = RxString(iconOfSubreddit);
        controller.idOfSubredditToSubmittPost = RxString(idOfSubreddit);
        controller.subredditToSubmitPost.update((val) { });
        Get.forceAppUpdate();
        controller.getFlairsOfSubreddit();

      },
    );
  }
}
