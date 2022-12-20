import 'package:flutter/material.dart';
import '../models/myprofile_data.dart';
import 'overview_myprofile_web.dart';
import '../screens/myprofile_screen.dart';
import '../../widgets/profile_comments.dart';
import '../widgets/myprofile_about.dart';
import '../../widgets/myprofile_post_web.dart';
import '../../widgets/myprofile_comment_web.dart';

class MyProfileWeb extends StatelessWidget {
  MyProfileWeb(
      {Key? key,
      required TabBar tabBar,
      required this.loadProfile,
      required this.isLoading,
      required this.controller})
      : _tabBar = tabBar,
        super(key: key);

  final TabBar _tabBar;
  final MyProfileData loadProfile;
  bool isLoading;
  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255,218, 224, 230),
        appBar: PreferredSize(
        preferredSize: _tabBar.preferredSize,
        child: Material(
          color: Colors.white,
          child: _tabBar,
        )),
        body: isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : TabBarView(controller: controller, children: [
                OverviewMyProfileWeb(loadProfile: loadProfile),
                // MyProfilePostWeb(),
                MyProfileCommentWeb(),
                MyProfileCommentWeb(),
                MyProfileCommentWeb(),
                MyProfileCommentWeb(),
                MyProfileCommentWeb(),
                MyProfileCommentWeb(),
                MyProfileAbout(
                    int.parse(loadProfile.postKarma.toString()),
                    int.parse(loadProfile.commentkarma.toString()),
                    loadProfile.description.toString())
              ]));
  }
}
