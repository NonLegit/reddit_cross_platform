import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_app/models/subreddit_about%20_rules.dart';
import 'dart:convert';
import '../../network/constant_endpoint_data.dart';
import '../../network/dio_client.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../../widgets/subreddit_about.dart';
import '../models/subreddit_data.dart';
import '../../screens/subreddit_search_screen.dart';
import '../widgets/subreddit_pop_up_menu_button.dart';
import '../widgets/subreddit_join_buttons.dart';
import '../../widgets/drawer.dart';
import '../models/subreddit_data.dart';

class SubredditScreen extends StatefulWidget {
  static const routeName = '/Subreddit';

  @override
  State<SubredditScreen> createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen>
    with TickerProviderStateMixin {
  //================Tab bar==================//
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'About'),
  ];
  TabController? _controller;
  TabBar get _tabBar => TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: tabs,
        labelColor: Colors.black,
        labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //==================notification=========================//
  String dropDownValue = "Low";
  IconData icon = Icons.notifications;
  var _isLoading = false;
  var _isInit = true;
  //=========================================//
  var userName;
  SubredditData? loadedSubreddit=SubredditData(
      id: 10,
      name: 'Cooking',
      subredditPicture:
          'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
      subredditBackPicture:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-750%2Fd30%2Feasy-basic-pancakes-horiz-1022%2Feasy-basic-pancakes-horiz-1022_0.jpg%3Fitok%3DXQMZkp_j',
      description: 'I\'m Chef',
      subredditLink:
          'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
      numOfMembers: 10398,
      numOfOnlines: 1789,
      rules: [
        SubredditAboutRules('no codeing', 'i hate coding'),
        SubredditAboutRules('no codeing', 'i hate cod'),
        SubredditAboutRules('no codeing', 'i hate code'),
        SubredditAboutRules('no codeing', 'i hate code')
      ],
      moderators: ['Ali', 'omer', 'zeinab','mazen'],
      isJoined: true);
  @override
  void initState() {
    // date= DateFormat.yMMMEd().format(toDay);
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================doing fetch=======================================//
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
  userName = ModalRoute.of(context)?.settings.arguments as String;
    //   DioClient.init();
    //   DioClient.get(path: subredditPath).then((responseSub) {
    //     loadedSubreddit = SubredditData.fromJson(json.decode(responseSub.data));
    //     DioClient.get(path: moderators).then((responseMod) {
    //       Map<String, dynamic> extractedDate = json.decode(responseMod.data);
    //       List<String> modsName = [];
    //       extractedDate.forEach((id, modDate) {
    //         modsName.add(modDate[userName]);
    //       });
    //       loadedSubreddit!.moderators = modsName;
    //       setState(() {
    //         _isLoading = false;
    //       });
    //     }).catchError((error) {});
    //   }).catchError((error) {});
    // }
    // _isInit = false;
    //==================================================//
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
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
                      title: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(137, 33, 33, 33),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 60.w,
                        height: 4.h,
                        //color: Color.fromARGB(157, 255, 245, 245),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SubredditSearchScreen.routeName);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.search_outlined),
                              Text(
                                'r/${loadedSubreddit!.name}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        SubredditPopupMenuButton(
                            loadedSubreddit!.subredditLink.toString(),
                            loadedSubreddit!.name.toString(),userName),
                        IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState!.openEndDrawer();
                            },
                            icon: Icon(
                              Icons.person_sharp,
                            ))
                        // AppDrawer(),
                      ],
                      expandedHeight: (loadedSubreddit!.description == null||loadedSubreddit!.description == '')
                          ? 35.h
                          : (35 +
                                  ((loadedSubreddit!.description
                                              .toString()
                                              .length /
                                          42) +
                                      7))
                              .h,
                      floating: false,
                      pinned: true,
                      snap: false,
                      bottom: PreferredSize(
                        preferredSize: _tabBar.preferredSize,
                        child: ColoredBox(
                          color: Colors.white,
                          child: _tabBar,
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              //Profile back ground
                              Container(
                                  height: (loadedSubreddit!.description ==null||loadedSubreddit!.description == '')
                                      ? 30.h
                                      : (30 +
                                              ((loadedSubreddit!.description)
                                                      .toString()
                                                      .length /
                                                  42) +
                                              7)
                                          .h,
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
                                          margin: EdgeInsets.only(top: 15),
                                          width: 100.w,
                                          height: 9.h,
                                          child: ListTile(
                                            title: Text(
                                                'r/${loadedSubreddit!.name.toString()}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Text(
                                              '${int.parse(loadedSubreddit!.numOfMembers.toString())} members .${int.parse(loadedSubreddit!.numOfOnlines.toString())} online ',
                                            ),
                                            trailing: JoinButtons(
                                                isJoined: loadedSubreddit!
                                                    .isJoined as bool,
                                                icon: icon,
                                                dropDownValue: dropDownValue,
                                                communityName: loadedSubreddit!
                                                    .name
                                                    .toString()),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                              '${loadedSubreddit!.description.toString()}',
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                      ],
                                    )),
                              ),
                              //for profile picture
                              Positioned(
                                top: 90,
                                right: 260,
                                left: 0,
                                bottom: 120,
                                child: Container(
                                  width: 200,
                                  height: 200,
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
              body: _isLoading
                  ? const Center(
                      child: Icon(
                        Icons.reddit,
                        color: Colors.blue,
                      ),
                    )
                  : TabBarView(controller: _controller, children: [
                      const ProfilePosts(
                          routeNamePop: SubredditScreen.routeName),
                      SubredditAbout(
                          rules: loadedSubreddit!.rules
                              as List<SubredditAboutRules>,
                          moderators:
                              loadedSubreddit!.moderators as List<String>,userName: userName,)
                    ])),
      // drawer: AppDrawer(),
      endDrawer: _isLoading
          ? const Center(
              child: Icon(
                Icons.reddit,
                color: Colors.blue,
              ),
            )
          : AppDrawer(),
    );
  }
}
