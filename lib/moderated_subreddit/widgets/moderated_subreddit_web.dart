import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/subreddit_about _rules.dart';
import '../../widgets/subreddit_about.dart';
import '../../widgets/subreddit_join_button_web.dart';
import '../../models/subreddit_data.dart';
import '../widgets/moderated_subreddite_post_web.dart';
import '../../widgets/back_to_button.dart';

class ModeratedSubredditWeb extends StatelessWidget {
  String userName;
  ModeratedSubredditWeb(
      {Key? key,
      required this.userName,
      required this.tabBar,
      required this.loadedSubreddit,
      required this.isLoading,
      required this.controller}) {
    print(loadedSubreddit!.name);
  }
  //===============Drawer Bar=====================//
  bool isOnline = true;
  SubredditData? loadedSubreddit;
  final TabBar tabBar;
  bool isLoading;
  TabController? controller;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton:
            BackToTopButton(scrollController: scrollController),
        body: isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        elevation: 4,
                        backgroundColor: innerBoxIsScrolled
                            ? const Color.fromARGB(137, 33, 33, 33)
                            : Colors.white,
                        expandedHeight: 40.h,
                        floating: false,
                        pinned: true,
                        snap: false,
                        bottom: PreferredSize(
                          preferredSize: tabBar.preferredSize,
                          child: ColoredBox(
                            color: Colors.white,
                            child: tabBar,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(children: <Widget>[
                            Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: <Widget>[
                                //Profile back ground
                                Container(
                                    height: 40.h,
                                    width: 100.w,
                                    color: Colors.white,
                                    child: Image.network(
                                      loadedSubreddit!.subredditBackPicture
                                          .toString(),
                                      fit: BoxFit.cover,
                                    )),
                                // for name , members ,online and description
                                Positioned(
                                  top: 150,
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                      // padding: EdgeInsets.only(left: 250),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            //margin: EdgeInsets.only(top: 15),
                                            width: 100.w,
                                            height: 15.h,
                                            padding: EdgeInsets.only(left: 250),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 10.w,
                                                  height: 20.h,
                                                  // margin: EdgeInsets.only(bottom: 30,top: 40),

                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            loadedSubreddit!
                                                                .subredditPicture
                                                                .toString()),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                Container(
                                                  height: 20.h,
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          '${loadedSubreddit!.name.toString()}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 35)),
                                                      Text(
                                                        'r/${loadedSubreddit!.name.toString()}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SubredditJoinButtonWeb(
                                                    isJoined: loadedSubreddit!
                                                        .isJoined as bool,
                                                    // icon: icon,
                                                    //dropDownValue: dropDownValue,
                                                    communityName:
                                                        loadedSubreddit!.name
                                                            .toString()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ];
                },
                body: isLoading
                    ? const Center(
                        child: Icon(
                          Icons.reddit,
                          color: Colors.blue,
                        ),
                      )
                    : TabBarView(controller: controller, children: [
                        ModeratedSubredditePostWeb(
                          loadedSubreddit: loadedSubreddit,
                        ),
                        // SubredditPosts(routeNamePop: SubredditScreen.routeName),
                        SubredditAbout(
                          rules: loadedSubreddit!.rules
                              as List<SubredditAboutRules>,
                          moderators:
                              loadedSubreddit!.moderators as List<String>,
                          userName: userName,
                        )
                      ])));
  }
}
