import 'package:flutter/material.dart';
import '../models/others_profile_data.dart';
import '../widgets/overview_other_profile_web.dart';
import '../widgets/others_profile_about.dart';
import '../../widgets/myprofile_comment_web.dart';
import '../../widgets/back_to_button.dart';
import '../../widgets/myprofile_post_web.dart';
import '../screens/others_profile_screen.dart';
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
              floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.only(end: 320.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(OthersProfileScreen.routeName,
                  arguments: loadProfile.userName);
            },
            child: Text(
              '      Back to top     ',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), backgroundColor: Colors.blue),
          ),
        ),
        body: isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : TabBarView(controller: controller, children: [
                OverviewOtherProfileWeb(
                    loadProfile: loadProfile,
                    scrollController: scrollController),
                MyProfilePostWeb(userName: loadProfile.userName.toString()),
                MyProfileCommentWeb(
                    scrollController: scrollController,
                    userName: loadProfile.userName.toString()),
                OthersProfileAbout(
                    int.parse(loadProfile.postKarma.toString()),
                    int.parse(loadProfile.commentkarma.toString()),
                    loadProfile.description.toString())
              ]));
  }
}
