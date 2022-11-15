import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_code_style/flutter_code_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/create_community/screens/create_community.dart';
import 'package:post/myprofile/screens/myprofile_screen.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:post/other_profile/screens/others_profile_screen.dart';
import 'package:post/subreddit/screens/subreddit_screen.dart';
import '../providers/cubit/states.dart';
import '../../chat/chat.dart';
import '../../createpost/screens/createpost.dart';
import '../../discover/discover.dart';

import '../../icons/icon_broken.dart';

import '../providers/cubit/cubit.dart';
import '../../notification/screens/notifications_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';

class homeLayoutScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  State<homeLayoutScreen> createState() => _homeLayoutScreenState();
}

class _homeLayoutScreenState extends State<homeLayoutScreen> {
// Value for DropDownButton
  String dropDownButtonValue = "Home";
  List<String> list = ["Home", "Popular"];

  // Icons when expansionlist at the drawer
  dynamic icRecent = Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating = Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities = Icon(IconBroken.Arrow___Right_2);
  // bools to handle the Expansion pannels in drawer
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  //Unique  KEYS to handle the scaffold and form and drawer
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var drawerKey = GlobalKey<DrawerControllerState>();
  // drawer functions
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

// for dropdown list
  String dropValue = "Home";
  // Lists for DropDown Menu at appBar
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
        child: ButtonBar(
      children: [Text("Home")],
    )),
    DropdownMenuItem(
        child: ButtonBar(
      children: [Text("Popular")],
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => layoutCubit(),
      child: BlocConsumer<layoutCubit, layoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = layoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                // To make style for status bar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 1.0,
                backgroundColor: Colors.white,
                leading: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () => showDrawer(context),
                    icon:
                        Icon(Icons.menu_rounded, color: Colors.black, size: 30),
                  );
                }),
                title: ElevatedButton.icon(
                  onPressed: () {
                    print("ell");
                  },
                  icon: Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  ),
                  label: Icon(
                    IconBroken.Arrow___Down_2,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all(Size(100.0, 20.0)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[300]),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.Search,
                      color: Colors.black87,
                      size: 28.0,
                    ),
                  ),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showEndDrawer(context),
                      icon: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
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
                ]),
            //   body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10.0),
              child: Container(
                height: 90.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: BottomNavigationBar(
                  elevation: 0,
                  selectedItemColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeButtomNavigationBar(index);
                    if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createPostScreen()));
                    }
                    if (index == 4) {
                      Navigator.of(context)
                          .pushNamed(NotificationScreen.routeName);
                    }
                  },
                  items: cubit.bottomItems,
                ),
              ),
            ),
            endDrawer: endDrawerHome(context),

            drawer: drawerHome(context),
          );
        },
      ),
    );
  }

  Drawer drawerHome(context) {
    List<ListTile> Following = [
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(OthersProfileScreen.routeName, arguments: 'ahmed sayed'),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("u/" + "ahmed sayed"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(OthersProfileScreen.routeName, arguments: 'ahmed '),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("u/" + "ahmed"),
        horizontalTitleGap: 0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(OthersProfileScreen.routeName, arguments: 'zienab'),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              IconBroken.Star,
            )),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
        title: Text("u/" + "zienab"),
        horizontalTitleGap: 0,
      ),
    ];

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
                "Floowing ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
              children: [
                Container(
                  height: Following.length * 70,
                  child: ListView.builder(
                    itemCount: Following.length,
                    itemBuilder: (context, index) {
                      return Following[index];
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
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
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
                Navigator.of(context)
                    .pushNamed(MyProfileScreen.routeName, arguments: 'ahmed');
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
