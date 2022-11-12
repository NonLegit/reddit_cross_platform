import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/home/screens/home_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../icons/icon_broken.dart';
import '../widgets/list_tile_widget.dart';
import '../../networks/dio_client.dart';
import '../widgets/three_dots_widget.dart';
import './messages_main_screen.dart';
import './notifications_main_screen.dart';
import '../../networks/const_endpoint_data.dart';
import '../../home/providers/cubit/cubit.dart';
import '../../home/providers/cubit/states.dart';
import '../../home/widgets/component.dart';
import '../../widgets/loading_reddit.dart';
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
  var currentIndex=4;
  @override
  void initState() {
    // TODO: implement initState
    DioClient.init();

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await DioClient.get(path: notificationResults).then((value) {
      json.decode(value.data).forEach((value) {
        usersAllNotificatiion.add(HashMap.from(value));
      });
    });
    setState(() {
      returned = true;
    });

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ThreeDotsWidget(listOfWidgets: [
              ListTileWidget(icon: Icons.create_outlined, title: 'New message'),
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
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          elevation: 2,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
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
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => homeLayoutScreen()));
            }
          },
        ),
          endDrawer: endDrawerHome(context),
         drawer: drawerHome(),
        body: TabBarView(children: [
          !returned
              ? LoadingReddit()
              : NotificationsMainScreen(
                  usersAllNotificatiion: usersAllNotificatiion,
                  changeNumOfNotification: _changeNumOfNotification),
          const MessagesMainScreen(),
        ]),
      ),
    );
  
  
  }
   Drawer drawerHome() {
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

