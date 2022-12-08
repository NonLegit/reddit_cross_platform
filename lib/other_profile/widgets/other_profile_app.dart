import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/others_profile_about.dart';
import '../models/others_profile_data.dart';
import '../widgets/position_in_flex_appbar_otherprofile.dart';
import '../widgets/pop_down_menu.dart';
import '../screens/others_profile_screen.dart';
class OtherProfileApp extends StatelessWidget {
    final String userName;
final  OtherProfileData loadProfile;
  bool isOnline = true;
  final TabBar tabBar;
  bool isLoading;
  TabController? controller;
 OtherProfileApp({
    Key? key,
        required this.userName,
    required this.controller,
    required this.isLoading,
    required this.tabBar,
    required this.loadProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      elevation: 4,
                      backgroundColor: Colors.blue,
                      title: Visibility(
                        visible: innerBoxIsScrolled,
                        child: Text('u/${loadProfile.displayName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      expandedHeight: (loadProfile.description == null ||
                              loadProfile.description == '')
                          ? 54.h
                          : (54 +
                                  ((loadProfile.description.toString().length /
                                          42) +
                                      7))
                              .h,
                      floating: false,
                      pinned: true,
                      snap: false,
                      bottom: PreferredSize(
                          preferredSize: tabBar.preferredSize,
                          child: ColoredBox(
                            color: Colors.white,
                            child: tabBar,
                          )),
                      actions: <Widget>[
                        PopDownMenu(userName:loadProfile.userName.toString(),buildContext:context),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(children: <Widget>[
                          Stack(
                            children: <Widget>[
                              //Profile back ground
                              Container(
                                // color: Colors.blue,
                                height: (loadProfile.description == null ||
                                        loadProfile.description == '')
                                    ? 51.h
                                    : (51 +
                                            (loadProfile.description
                                                    .toString()
                                                    .length /
                                                42) +
                                            7)
                                        .h,
                                width: 100.w,
                                foregroundDecoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0, 1],
                                  ),
                                ),
                                child: Image.network(
                                  loadProfile.profileBackPicture.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //),
                              //tomake widget position
                              PositionInFlexAppBarOtherProfile(
                                  loadProfile: loadProfile)
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ];
              },
              body: isLoading
                  ? LoadingReddit()
                  : TabBarView(controller: controller, children: [
                      ProfilePosts(routeNamePop: OthersProfileScreen.routeName,userName: userName),
                      ProfileComments(),
                      OthersProfileAbout(
                          int.parse(loadProfile.postKarma.toString()),
                          int.parse(loadProfile.commentkarma.toString()),
                          loadProfile.description.toString())
                    ])
            );
  }
}
