import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import '../widgets/myprofile_about.dart';
import '../widgets/profile_comments.dart';
import '../widgets/profile_posts.dart';
import './edit_profile_screen.dart';
import './user_followers_screen.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/myprofile';

  @override
  State<MyProfileScreen> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  var imageUrlBack =
      'https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac';

  var imageUrlProfile =
      'https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg';

  var id;

  var userName = 'Zeinab-Moawad';

  var description = 'I\'m student in cairo university';

  var StartTime;

  var numOfDays = 28;

  var numOfFollowers = 2;

  var numOfPosts = 1;

  var numOfComments = 1;

  var numOfAwarder = 1;

  var numOfAwardee = 1;
  DateTime toDay = DateTime.now();
  late String date;
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'Comments'),
    const Tab(text: 'About'),
  ];
  TabBar get _tabBar => TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: tabs,
        labelColor: Colors.black,
        labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  late TabController _controller;
  @override
  void initState() {
    // date= DateFormat.yMMMEd().format(toDay);
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  elevation: 4,
                  backgroundColor: Colors.blue,
                  title: Visibility(
                    visible: innerBoxIsScrolled,
                    child: Text(
                      'u/$userName',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  expandedHeight: (description == '')
                      ? 64.h
                      : (64 + ((description.length / 42) + 5)).h,
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
                        children: <Widget>[
                          //Profile back ground
                          Container(
                            //  color: Colors.blue,
                            height: (description == '')
                                ? 61.h
                                : (61 + (description.length / 42) + 5).h,
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
                              imageUrlBack,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //tomake widget position
                          Positioned(
                            top: 122,
                            right: 10,
                            width: 95.w,
                            height: 100.h,
                            child: Container(
                              // color: Colors.blue,
                              padding: const EdgeInsets.all(20),
                              //color: Colors.black54,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  //profile image
                                  Container(
                                    //  margin: EdgeInsets.only(: 50),
                                    //color: Colors.orange,
                                    child: CircleAvatar(
                                      radius: 43,
                                      backgroundImage:
                                          NetworkImage(imageUrlProfile),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //Edit
                                  Container(
                                      width: 23.w,
                                      height: 6.h,
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed(
                                                EditProfileScreen.routeName),
                                        style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white)),
                                            shape: MaterialStateProperty.all(
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(22)))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromARGB(
                                                        137, 33, 33, 33)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          // style: Theme.of(context).textTheme.headline6,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //username
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  //followers
                                  Container(
                                      padding: const EdgeInsets.all(0),
                                      alignment: Alignment.bottomLeft,
                                      height: 4.5.h,
                                      width: 40.w,
                                      child: TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed(UserFollowersScreen
                                                  .routeName),
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '$numOfFollowers followers',
                                                  style: const TextStyle(
                                                      //backgroundColor: Colors.orange,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 15,
                                                )
                                              ]))),
                                  //name and discibtions
                                  Text(
                                      'u/$userName . $numOfDays . 1m .1 karma.oct 2,2022',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13)),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: (description == '')
                                        ? 0.h
                                        : (0 + (description.length / 42) + 5).h,
                                    child: Text(description,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
                                  ),

                                  //sotial links
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(EditProfileScreen.routeName),
                                    label: const Text(
                                      'Add social link',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 44, 44, 44))),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(controller: _controller, children: [
            const ProfilePosts(routeNamePop: MyProfileScreen.routeName),
            ProfileComments(),
            MyProfileAbout(numOfPosts, numOfComments, numOfAwarder,
                numOfAwardee, description)
          ])),
    );
  }
}
