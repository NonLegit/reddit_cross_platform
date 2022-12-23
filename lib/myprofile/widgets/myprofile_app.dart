import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/position_in_flex_app_bar_myprofile.dart';
import '../widgets/myprofile_about.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../models/myprofile_data.dart';
import '../screens/myprofile_screen.dart';

class MyProfileApp extends StatelessWidget {
  final String userName;
  MyProfileData loadProfile;
  bool isOnline = true;
  final TabBar tabBar;
  bool isLoading;
  TabController? controller;
  MyProfileApp({
    Key? key,
    required this.userName,
    required this.controller,
    required this.isLoading,
    required this.tabBar,
    required this.loadProfile,
  }) : super(key: key);
   final GlobalKey<NestedScrollViewState> documentsNestedKey = GlobalKey();
   ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
         key: documentsNestedKey,
         controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                elevation: 4,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                title:
                    Text('u/${loadProfile.displayName}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                expandedHeight: (loadProfile.description == null ||
                        loadProfile.description == '')
                    ? 54.h
                    : (54 +
                            ((loadProfile.description.toString().length / 42) +
                                7))
                        .h,
                floating: false,
                pinned: true,
                snap: false,
                bottom: PreferredSize(
                  preferredSize:Size(40.w,tabBar.preferredSize.height),
                  child: ColoredBox(
                    color: Colors.white,
                    child: tabBar,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        //Profile back ground
                        Container(
                          height: (loadProfile.description == null ||
                                  loadProfile.description == '')
                              ? 56.5.h
                              : (56.5 +
                                      ((loadProfile.description)
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
                        //tomake widget position
                        PositionInFlexAppBarMyProfile(loadProfile: loadProfile)
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ];
        },
        body: isLoading
            ? const LoadingReddit()
            : TabBarView(controller: controller, children: [
                ProfilePosts(
                  routeNamePop: MyProfileScreen.routeName,
                  userName: userName,
                ),
                ProfileComments(userName: userName),
                MyProfileAbout(
                    int.parse(loadProfile.postKarma.toString()),
                    int.parse(loadProfile.commentkarma.toString()),
                    loadProfile.description.toString())
              ]));
  }
}
