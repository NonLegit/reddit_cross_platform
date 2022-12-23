import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/position_for_moderated_subredditInfo.dart';
import '../widgets/moderated_subreddit_pop_up_menu_button.dart';
import '../../widgets/subreddit_posts.dart';
import '../../models/subreddit_data.dart';
import '../screens/moderated_subreddit_screen.dart';
import '../../screens/subreddit_search_screen.dart';
import '../../models/subreddit_about _rules.dart';
import '../../widgets/subreddit_about.dart';

class ModeratedSubredditApp extends StatelessWidget {
  final String userName;
  SubredditData? loadedSubreddit;
  bool isOnline = true;
  final TabBar tabBar;
  bool isLoading;
  TabController? controller;
  ModeratedSubredditApp({
    required this.userName,
    required this.controller,
    required this.isLoading,
    required this.tabBar,
    required this.loadedSubreddit,
    Key? key,
  }) : super(key: key);
  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                elevation: 4,
                foregroundColor: Colors.white,
                backgroundColor:
                const Color.fromARGB(137, 33, 33, 33),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                title: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(137, 33, 33, 33),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 60.w,
                  height: 5.h,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SubredditSearchScreen.routeName);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'r/${loadedSubreddit!.name}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ModeratedSubredditPopupMenuButton(
                    linkOfCommuinty: loadedSubreddit!.subredditLink.toString(),
                    communityName: loadedSubreddit!.name.toString(),
                    userName: userName,
                    isJoined: loadedSubreddit!.isJoined as bool,
                  ),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showEndDrawer(context),
                      icon: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
                            radius: 30.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(end: 2, bottom: 2),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 4,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
                expandedHeight: (loadedSubreddit!.description == null ||
                        loadedSubreddit!.description == '')
                    ? 35.h
                    : (35 +
                            ((loadedSubreddit!.description.toString().length /
                                    42) +
                                7))
                        .h,
                floating: false,
                pinned: true,
                snap: false,
                bottom: PreferredSize(
                  preferredSize:tabBar.preferredSize,
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
                            height: (loadedSubreddit!.description == null ||
                                    loadedSubreddit!.description == '')
                                ? 35.h
                                : (35 +
                                        ((loadedSubreddit!.description)
                                                .toString()
                                                .length /
                                            42) +
                                        7)
                                    .h,
                            width: 100.w,
                            color: Colors.white,
                            child: Image.network(
                              loadedSubreddit!.subredditBackPicture.toString(),
                              fit: BoxFit.cover,
                            )),
                        // for name , members ,online and description
                        PositionForModeratedSubredditInfo(
                            loadedSubreddit: loadedSubreddit,
                            userName: userName),
                        //for profile picture
                        Positioned(
                          top: 9.h,
                          right: 65.w,
                          left: 0,
                          bottom: 20.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(loadedSubreddit!
                                      .subredditPicture
                                      .toString()),
                                  fit: BoxFit.fill),
                            ),
                          ),
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
                SubredditPosts(
                    routeNamePop: ModeratedSubredditScreen.routeName,
                    subredditName: loadedSubreddit!.name as String),
                SubredditAbout(
                    rules: loadedSubreddit!.rules as List<SubredditAboutRules>,
                    moderators: loadedSubreddit!.moderators as List<String>,
                    userName: userName)
              ]));
  }
}
