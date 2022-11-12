import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:test_app/models/subreddit_about%20_rules.dart';
import '../../models/subreddit_about _rules.dart';
import 'dart:convert';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../../widgets/subreddit_about.dart';
import '../../icons/icon_broken.dart';
import '../models/subreddit_data.dart';
import '../../screens/subreddit_search_screen.dart';
import '../widgets/subreddit_pop_up_menu_button.dart';
import '../widgets/subreddit_join_buttons.dart';
import '../../widgets/drawer.dart';
import '../models/subreddit_data.dart';
import '../widgets/subreddit_posts.dart';

class SubredditScreen extends StatefulWidget {
  static const routeName = '/Subreddit';

  @override
  State<SubredditScreen> createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen>
    with TickerProviderStateMixin {
      //===============Drawer Bar=====================//
        bool isOnline = true;
  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }
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
  SubredditData? loadedSubreddit = SubredditData(
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
      moderators: ['Ali', 'omer', 'zeinab', 'mazen'],
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
                      leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
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
                            loadedSubreddit!.name.toString(),
                            userName),
                         Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showEndDrawer(context),
                      icon: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=2iWzRT-vma8AX-PiMqC&_nc_ht=scontent.fcai22-1.fna&oh=00_AfBEvYZoMur64QVXcxLFJVnuJaaLWR183dRaZG6nN2Jdhw&oe=636EEF08'),
                            radius: 30.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                end: 2, bottom: 2),
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
                                  height: (loadedSubreddit!.description ==
                                              null ||
                                          loadedSubreddit!.description == '')
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
                      SubredditPosts(routeNamePop: SubredditScreen.routeName),
                      SubredditAbout(
                        rules:
                            loadedSubreddit!.rules as List<SubredditAboutRules>,
                        moderators: loadedSubreddit!.moderators as List<String>,
                        userName: userName,
                      )
                    ])),
      // drawer: AppDrawer(),
      endDrawer: _isLoading
          ? const Center(
              child: Icon(
                Icons.reddit,
                color: Colors.blue,
              ),
            )
          : endDrawerHome(context)
    );
  }
    Drawer endDrawerHome(BuildContext context) {
    return Drawer(
            elevation: 20.0,
            width: 250.0,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: 250.0,
                    height: 250.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                                'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=2iWzRT-vma8AX-PiMqC&_nc_ht=scontent.fcai22-1.fna&oh=00_AfBEvYZoMur64QVXcxLFJVnuJaaLWR183dRaZG6nN2Jdhw&oe=636EEF08'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'u/' + 'Ahmed Fawzy',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  if (isOnline) {
                                    isOnline = false;
                                  } else {
                                    isOnline = true;
                                  }
                                });
                              },
                              icon: CircleAvatar(
                                radius: 4,
                                backgroundColor: isOnline
                                    ? Colors.green
                                    : Colors.grey[200],
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[200]),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                              color: isOnline
                                                  ? Colors.green
                                                  : Colors.black54)))),
                              label: Text(
                                "Online Status: " +
                                    "${isOnline ? "On" : "Off"}",
                                style: TextStyle(
                                    color: isOnline
                                        ? Colors.green
                                        : Colors.black54),
                              ),
                            ),
                          ),
                        ])),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                ListTile(
                  horizontalTitleGap: 3,
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text(
                    'My profile',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  horizontalTitleGap: 3,
                  leading: Icon(IconBroken.Category),
                  title: Text(
                    'Create a community',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  horizontalTitleGap: 3,
                  leading: Icon(Icons.save),
                  title: Text(
                    'Saved',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  horizontalTitleGap: 3,
                  leading: Icon(Icons.access_time_outlined),
                  title: Text(
                    'History',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 230.0,
                ),
                Expanded(
                  child: ListTile(
                    horizontalTitleGap: 3,
                    leading: Icon(IconBroken.Setting),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
  }

}
