import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../post/widgets/post.dart';
import '../controller/home_controller.dart';

class SavedPosts extends StatelessWidget {
   SavedPosts({Key? key}) : super(key: key);
  final HomeController controller = Get.put(
    HomeController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
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
    );
  }
}
