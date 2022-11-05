import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import '../widgets/myprofile_about.dart';
import '../widgets/profile_comments.dart';
import '../widgets/profile_posts.dart';
import '../widgets/others_profile_about_.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OthersProfileScreen extends StatefulWidget {
  static const routeName = '/OthersProfileScreen';

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen>
    with TickerProviderStateMixin {
  var imageUrlBack =
      'https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac';

  var imageUrlProfile =
      'https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg';

  var id;

  var userName = 'Zeinab-Moawad';

  var description = 'I\'m student in cairo university';
  // 'i00000000000kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkoooooooooooooooooooooooooooooooooooooookkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkyyyyyyyyyyyyyyyyyyyyyyyyyyuuuuuuugggggggggvvvdddddfffdddddffffghhjjkkoouytesszxcvbhh';

  var StartTime;

  var numOfDays = 28;

  var numOfFollowers = 2;

  var numOfPosts = 1;

  var numOfComments = 1;

  var numOfAwarder = 1;

  var numOfAwardee = 1;
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
                    child: Text('u/$userName',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  expandedHeight: (description == '')
                      ? 54.h
                      : (54 + ((description.length / 42) + 7)).h,
                  floating: false,
                  pinned: true,
                  snap: false,
                  bottom: PreferredSize(
                      preferredSize: _tabBar.preferredSize,
                      child: ColoredBox(
                        color: Colors.white,
                        child: _tabBar,
                      )),
                  actions: <Widget>[
                    const PopDownMenu(),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          //Profile back ground
                          Container(
                            // color: Colors.blue,
                            height: (description == '')
                                ? 51.h
                                : (51 + (description.length / 42) + 7).h,
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
                          //),
                          //tomake widget position
                          Positioned(
                            top: 90,
                            right: 10,
                            width: 95.w,
                            height: 100.h,
                            child: Container(
                              // alignment: Alignment.topLeft,
                              //color: Colors.blue,
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
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        NetworkImage(imageUrlProfile),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //Follow and invite
                                  Row(
                                    children: [
                                      Container(
                                          width: 23.w,
                                          height: 6.h,
                                          child: OutlinedButton(
                                            onPressed: null,
                                            style: ButtonStyle(
                                                //shape: Outlin,

                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.white)),
                                                shape: MaterialStateProperty.all(
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30)))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            137, 33, 33, 33)),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            child: const Text(
                                              'Follow',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          )),
                                      Container(
                                          width: 15.w,
                                          height: 6.h,
                                          child: InviteButton()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //username
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  //followers
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.bottomLeft,
                                    height: 4.5.h,
                                    width: 40.w,
                                    //  color: Colors.black,
                                    child: TextButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$numOfFollowers followers',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
                                              textAlign: TextAlign.end,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15,
                                            )
                                          ]),
                                    ),
                                  ),
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
                                  //name and discibtions

                                  Container(
                                    width: 100.w,
                                    height: (description == '')
                                        ? 0.h
                                        : (0 + (description.length / 42) + 7).h,
                                    child: Text(description,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
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
            const ProfilePosts(routeNamePop: OthersProfileScreen.routeName),
            ProfileComments(),
            OthersProfileAbout(numOfPosts, numOfComments, numOfAwarder,
                numOfAwardee, description)
          ])),
    );
  }
}

class InviteButton extends StatelessWidget {
  const InviteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width * 0.30,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text('invite'),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ButtonStyle(
          side:
              MaterialStateProperty.all(const BorderSide(color: Colors.white)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(137, 33, 33, 33)),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      child: const Icon(Icons.person_add_alt_sharp),
    );
  }
}

class PopDownMenu extends StatelessWidget {
  const PopDownMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.local_post_office_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Send a message',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Get them help and support',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.block_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Block account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.flag_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Report acount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ]);
  }
}
