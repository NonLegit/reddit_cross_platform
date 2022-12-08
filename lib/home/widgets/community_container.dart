import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';

import '../../create_community/screens/create_community.dart';
class CommunityContainer extends StatelessWidget {
  // const SubredditContainer({Key? key}) : super(key: key);
  final HomeController controller = Get.put(
    HomeController(),
  );
  String nameOfSubreddit="";
  String iconOfSubreddit='';
  CommunityContainer(
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
      onTap: ()
      {
        Navigator.of(context)
            .pushNamed(CreateCommunity.routeName);
      },
    );
  }
}
