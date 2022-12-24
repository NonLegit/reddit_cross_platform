import 'package:flutter/material.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/subreddit_about _rules.dart';
import '../../widgets/subreddit_about.dart';
import '../../models/subreddit_data.dart';
import '../providers/subreddit_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/subreddit_post_web.dart';
import '../../widgets/subreddit_join_button_web.dart';
import '../../widgets/back_to_button.dart';
import '../screens/subreddit_screen.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class SubredditWeb extends StatelessWidget {
  String userName;
  SubredditWeb(
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
    bool showTheme = Provider.of<SubredditProvider>(context, listen: false)
        .gettingTheme as bool;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.only(end: 320.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SubredditScreen.routeName,
                  arguments:userName);
            },
            child: Text(
              '      Back to top     ',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), backgroundColor: Colors.blue),
          ),
        ),
        backgroundColor: (showTheme)
            ? Color.fromARGB(255, 218, 224, 230)
            : (loadedSubreddit!.theme!.contains('https'))
                ? Image.network(loadedSubreddit!.theme.toString()).color
                : '#6ae792'.toColor(),
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
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
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
                                                          '${loadedSubreddit!.displayName.toString()}',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      35)),
                                                      Text(
                                                        'r/${loadedSubreddit!.name.toString()}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SubredditJoinButtonWeb(
                                                    isJoined: loadedSubreddit!
                                                        .isJoined as bool,
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
                    ? LoadingReddit()
                    : TabBarView(controller: controller, children: [
                        SubredditePostWeb(
                          loadedSubreddit: loadedSubreddit,
                        ),
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
