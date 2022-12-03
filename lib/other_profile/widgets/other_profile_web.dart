import 'package:flutter/material.dart';
import '../models/others_profile_data.dart';
import './overview_other_profile_web.dart';
import '../../widgets/profile_comments.dart';
import '../widgets/others_profile_about.dart';
import '../../widgets/myprofile_comment_web.dart';
import '../../widgets/myprofile_post_web.dart';

class OtherProfileWeb extends StatelessWidget {
  OtherProfileWeb(
      {Key? key,
      required TabBar tabBar,
      required this.loadProfile,
      required this.isLoading,
      required this.controller})
      : _tabBar = tabBar,
        super(key: key);

  final TabBar _tabBar;
  final OtherProfileData loadProfile;
  bool isLoading;
  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 218, 224, 230),
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
                MyProfilePostWeb(),
                MyProfileCommentWeb(),
                OthersProfileAbout(
                    int.parse(loadProfile.postKarma.toString()),
                    int.parse(loadProfile.commentkarma.toString()),
                    loadProfile.description.toString())
              ]));
  }
}
