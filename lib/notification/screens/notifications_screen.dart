import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../home/screens/home_layout.dart';
import '../../icons/icon_broken.dart';
import '../provider/notification_provider.dart';
import '../widgets/list_tile_widget.dart';
import '../../networks/dio_client.dart';
import '../widgets/three_dots_widget.dart';
import './messages_main_screen.dart';
import './notifications_main_screen.dart';
import '../../networks/const_endpoint_data.dart';
import '../../home/widgets/component.dart';
import '../../widgets/loading_reddit.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../create_community/screens/create_community.dart';
import '../../subreddit/screens/subreddit_screen.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = '/notifications-screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Icons when expansion
  dynamic icRecent = Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating = Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities = Icon(IconBroken.Arrow___Right_2);
  // bools
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  bool hover = false;
  bool markAsRead = false;
  //Keys
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var drawerKey = GlobalKey<DrawerControllerState>();
  //Model Reccent visited
  List<ListTile> recentlyVisited = [
    ListTile(
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "Cross_platform"),
      horizontalTitleGap: 0,
    ),
    ListTile(
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "Egypt"),
      horizontalTitleGap: 0,
    ),
    ListTile(
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "memes"),
      horizontalTitleGap: 0,
    ),
  ];
  // drawer functions
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  List<ListTile> Communoties = [
    ListTile(
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            IconBroken.Star,
          )),
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "Cross_platform"),
      horizontalTitleGap: 0,
    ),
    ListTile(
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            IconBroken.Star,
          )),
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "Egypt"),
      horizontalTitleGap: 0,
    ),
    ListTile(
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            IconBroken.Star,
          )),
      leading: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.blue,
      ),
      title: Text("r/" + "memes"),
      horizontalTitleGap: 0,
    ),
  ];

  int unreadNotification = 0;
  bool returned = false;
  List<Map> usersAllNotificatiion = [];
  var currentIndex = 4;
  bool _isInit = true;
  @override
  void initState() {
    DioClient.initCreateCoumunity();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
          returned = false;
        });
      Provider.of<NotificationProvider>(context, listen: false)
          .getNotification()
          .then((value) {
        usersAllNotificatiion =
            Provider.of<NotificationProvider>(context, listen: false).list;
        setState(() {
          returned = true;
        });
      });
      // await DioClient.get(path: notificationResults).then((value) {
      //   print(value.data);
      //   value.data.forEach((value1) {
      //     usersAllNotificatiion.add(HashMap.from(value1));
      //   });
      // });
      // setState(() {
      //   returned = true;
      // });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  _changeNumOfNotification(value) {
    setState(() {
      unreadNotification = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var cubit =layoutCubit.get(context);
    return (!kIsWeb)
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  ThreeDotsWidget(listOfWidgets: [
                    ListTileWidget(
                        icon: Icons.create_outlined, title: 'New message'),
                    ListTileWidget(
                        icon: Icons.drafts_outlined,
                        title: 'Mark all inbox tabs as read')
                  ], height: 16),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showEndDrawer(context),
                      icon: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //       'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=2iWzRT-vma8AX-PiMqC&_nc_ht=scontent.fcai22-1.fna&oh=00_AfBEvYZoMur64QVXcxLFJVnuJaaLWR183dRaZG6nN2Jdhw&oe=636EEF08'),
                          //   radius: 30.0,
                          // ),
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
                backgroundColor: Colors.grey[50],
                titleSpacing: 0,
                elevation: 2,
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
                shadowColor: Colors.white,
                title: const Text('Inbox'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: TabBar(
                    indicatorWeight: 3,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 60),
                    isScrollable: true,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Badge(
                        toAnimate: false,
                        position: BadgePosition.topEnd(end: -10, top: -23),
                        shape: BadgeShape.circle,
                        borderRadius: BorderRadius.circular(4),
                        showBadge: unreadNotification != 0 ? true : false,
                        badgeContent: const Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Notifications',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'Messages',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: buttNavBar(),
                elevation: 0,
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (index) {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => homeLayoutScreen()));
                  }
                },
              ),
              endDrawer: endDrawerHome(context),
              drawer: drawerHome(context),
              body: TabBarView(children: [
                !returned
                    ? LoadingReddit()
                    : NotificationsMainScreen(
                        usersAllNotificatiion: usersAllNotificatiion,
                        changeNumOfNotification: _changeNumOfNotification),
                const MessagesMainScreen(),
              ]),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: Text('Hello')),
            body: Container(
              color: Colors.indigo[50],
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 25.w, right: 25.w),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.transparent,
                          height: 6.h,
                        ),
                        const Text(
                          'Notifications',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(NotificationScreen.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.blue, width: 0.2.h))),
                                child: const Text(
                                  'Activity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(MessagesMainScreen.routeName);
                              },
                              onHover: (value) {
                                setState(() {
                                  hover = value;
                                });
                              },
                              child: Text(
                                'Messages',
                                style: TextStyle(
                                    color: hover ? Colors.black : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            InkWell(
                                onTap: () {
                                  //TO DO MARK ALL AS READ
                                },
                                onHover: (value) {
                                  setState(() {
                                    markAsRead = value;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/envelope.png',
                                      color: Colors.grey,
                                      height: 3.h,
                                    ),
                                    Text(
                                      'Mark as read',
                                      style: TextStyle(
                                          color: markAsRead
                                              ? Colors.black
                                              : Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 4.h,
                        ),
                        Container(
                          color: Colors.white,
                          child: NotificationsMainScreen(
                              usersAllNotificatiion: usersAllNotificatiion,
                              changeNumOfNotification:
                                  _changeNumOfNotification),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Drawer drawerHome(context) {
    List<ListTile> Communoties = [
      ListTile(
        onTap: () => Navigator.of(context).pushNamed(
            ModeratedSubredditScreen.routeName,
            arguments: 'Cross_platform'),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "Cross_platform"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context).pushNamed(
            ModeratedSubredditScreen.routeName,
            arguments: 'Cross_platform'),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "Egypt"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context).pushNamed(
            ModeratedSubredditScreen.routeName,
            arguments: 'Cross_platform'),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "memes"),
        horizontalTitleGap: 0,
      ),
    ];
    List<ListTile> recentlyVisited = [
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(SubredditScreen.routeName, arguments: 'Cross_platform'),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "Cross_platform"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(SubredditScreen.routeName, arguments: 'Cross_platform'),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "Egypt"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(SubredditScreen.routeName, arguments: 'Cross_platform'),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("r/" + "memes"),
        horizontalTitleGap: 0,
      ),
    ];
    return Drawer(
      key: drawerKey,
      elevation: 20.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 3,
            ),
            ExpansionTile(
              onExpansionChanged: (isRecentlyVisitedPannelExpanded) {
                setState(() {
                  if (isRecentlyVisitedPannelExpanded) {
                    icRecent = TextButton(
                      onPressed: () => Drawer(
                        elevation: 20.0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Divider(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                      child: Text(
                        "See all",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    icRecent = IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Arrow___Right_2));
                  }
                });
              },
              initiallyExpanded: isRecentlyVisitedPannelExpanded,
              expandedAlignment: Alignment.bottomRight,
              trailing: icRecent,
              title: Text(
                "Recently Visited",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: recentlyVisited.length * 70,
                    child: ListView.builder(
                      itemCount: recentlyVisited.length,
                      itemBuilder: (context, index) {
                        return recentlyVisited[index];
                      },
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              onExpansionChanged: (isRecentlyVisitedPannelExpanded) {
                setState(() {
                  if (isRecentlyVisitedPannelExpanded) {
                    icModerating = Icon(
                      IconBroken.Arrow___Down_2,
                      color: Colors.black,
                    );
                  } else {
                    icModerating = IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Arrow___Right_2));
                  }
                });
              },
              initiallyExpanded: isRecentlyVisitedPannelExpanded,
              expandedAlignment: Alignment.bottomRight,
              trailing: icModerating,
              title: Text(
                "Moderating",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
              children: [
                ListTile(
                  horizontalTitleGap: 0.0,
                  leading: Icon(
                    Icons.shield_outlined,
                  ),
                  title: Text("Mod Feed"),
                ),
                ListTile(
                  horizontalTitleGap: 0.0,
                  leading: Icon(
                    Icons.quick_contacts_dialer_rounded,
                  ),
                  title: Text("Mod Queue"),
                ),
                ListTile(
                  horizontalTitleGap: 0.0,
                  leading: Icon(
                    Icons.mail,
                  ),
                  title: Text("Modmail"),
                ),
                Container(
                  height: Communoties.length * 70,
                  child: ListView.builder(
                    itemCount: Communoties.length,
                    itemBuilder: (context, index) {
                      return Communoties[index];
                    },
                  ),
                ),
              ],
            ),
            ExpansionTile(
              onExpansionChanged: (isRecentlyVisitedPannelExpanded) {
                setState(() {
                  if (isRecentlyVisitedPannelExpanded) {
                    icYourCommunities = Icon(
                      IconBroken.Arrow___Down_2,
                      color: Colors.black,
                    );
                  } else {
                    icYourCommunities = IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Arrow___Right_2));
                  }
                });
              },
              initiallyExpanded: isRecentlyVisitedPannelExpanded,
              expandedAlignment: Alignment.bottomRight,
              trailing: icModerating,
              title: Text(
                "Your Communities",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
              children: [
                ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CreateCommunity.routeName);
                    },
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      Icons.add,
                      size: 30.0,
                    ),
                    title: Text("Create a community")),
                Container(
                  height: Communoties.length * 70,
                  child: ListView.builder(
                    itemCount: Communoties.length,
                    itemBuilder: (context, index) {
                      return Communoties[index];
                    },
                  ),
                ),
              ],
            ),
            ListTile(
                onTap: () {},
                horizontalTitleGap: 0.0,
                leading: Icon(
                  Icons.stacked_bar_chart,
                  size: 25.0,
                ),
                title: Text("All")),
          ],
        ),
      ),
    );
  }

  Drawer endDrawerHome(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      width: 250.0,
      child: SingleChildScrollView(
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
                      // CircleAvatar(
                      //   radius: 60.0,
                      //   backgroundImage: NetworkImage(
                      //       'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
                      // ),
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
                            backgroundColor:
                                isOnline ? Colors.green : Colors.grey[200],
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[200]),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: isOnline
                                              ? Colors.green
                                              : Colors.black54)))),
                          label: Text(
                            "Online Status: " + "${isOnline ? "On" : "Off"}",
                            style: TextStyle(
                                color:
                                    isOnline ? Colors.green : Colors.black54),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(MyProfileScreen.routeName,
                    arguments: 'ahmed sayed');
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Category),
              title: Text(
                'Create a community',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(CreateCommunity.routeName);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.save),
              title: Text(
                'Saved',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Setting),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
