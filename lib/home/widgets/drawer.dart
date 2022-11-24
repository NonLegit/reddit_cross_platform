import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../create_community/screens/create_community.dart';
import '../../icons/icon_broken.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../../subreddit/screens/subreddit_screen.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  var drawerKey =GlobalKey<DrawerControllerState>();
  dynamic icRecent = Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating = Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities = Icon(IconBroken.Arrow___Right_2);
  // bools to handle the Expansion pannels in drawer
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    return drawerHome(context);
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
}
