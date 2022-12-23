import 'package:flutter/material.dart';
import '../models/myprofile_data.dart';
import '../../widgets/overview_myprofile_web.dart';
import '../widgets/myprofile_about.dart';
import '../../widgets/myprofile_comment_web.dart';
import '../../widgets/back_to_button.dart';
import '../../widgets/myprofile_post_web.dart';

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
  ScrollController scrollController = ScrollController();
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
        floatingActionButton:
            BackToTopButton(scrollController: scrollController),
        body: isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : TabBarView(controller: controller, children: [
                OverviewMyProfileWeb(
                  type: 'MyProfile',
                    loadProfile: loadProfile,
                    scrollController: scrollController),
                MyProfilePostWeb( userName: loadProfile.userName.toString()),
                  MyProfileCommentWeb(scrollController: scrollController,userName: loadProfile.userName.toString()),
                MyProfileAbout(
                    int.parse(loadProfile.postKarma.toString()),
                    int.parse(loadProfile.commentkarma.toString()),
                    loadProfile.description.toString())
              ]));
  }
}
