import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_code_style/flutter_code_style.dart';
import 'dart:convert';
//import 'package:test_app/providers/myprofile_provider.dart';
// import 'package:test_app/models/myprofile_Information_data.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../widgets/myprofile_about.dart';
import '../widgets/position_in_flex_app_bar_myprofile.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../../widgets/loading_reddit.dart';
import '../models/myprofile_data.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/myprofile';

  @override
  State<MyProfileScreen> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  //==================================//
  var _isLoading = false;
  var _isInit = true;
  //var userName = 'Zeinab-Moawad';
  var loadProfile;
  // = MyProfileData(
  //     id: 0,
  //     userName: 'Zeinab-Moawad',
  //     email: 'email',
  //     profilePicture:
  //         'https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg',
  //     profileBackPicture:
  //         'https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac',
  //     description: 'I\'m student',
  //     displayName: 'Zeinab moawad',
  //     createdAt: '2-09-2022',
  //     numOfDaysInReddit: 2,
  //     followersCount: 2,
  //     postKarma: 1,
  //     commentkarma: 1);
  //===================================//
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
  TabController? _controller;
  @override
  void initState() {
    // date= DateFormat.yMMMEd().format(toDay);
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
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
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      userName = ModalRoute.of(context)?.settings.arguments as String;
      DioClient.init();
      DioClient.get(path: myprofile).then((response) {
        loadProfile = MyProfileData.fromJson(json.decode(response.data));
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    //==================================================//
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final loadProfile = Provider.of<MyProfileProvider>(context, listen: false)
    //     .gettingMyProfileData;
    return Scaffold(
      body: _isLoading
          ? LoadingReddit()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      elevation: 4,
                      backgroundColor: Colors.blue,
                      title: Visibility(
                        visible: innerBoxIsScrolled,
                        child: Text('u/${loadProfile!.displayName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      expandedHeight: (loadProfile.description == null ||
                              loadProfile.description == '')
                          ? 54.h
                          : (54 +
                                  ((loadProfile.description.toString().length /
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
                            children: <Widget>[
                              //Profile back ground
                              Container(
                                //  color: Colors.blue,
                                height: (loadProfile.description == null ||
                                        loadProfile.description == '')
                                    ? 51.h
                                    : (51 +
                                            ((loadProfile.description)
                                                    .toString()
                                                    .length /
                                                42) +
                                            7)
                                        .h,
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
                                  loadProfile.profileBackPicture.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //tomake widget position
                              PositionInFlexAppBarMyProfile(
                                  loadProfile: loadProfile)
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ];
              },
              body: _isLoading
                  ? LoadingReddit()
                  : TabBarView(controller: _controller, children: [
                      ProfilePosts(routeNamePop: MyProfileScreen.routeName),
                      ProfileComments(),
                      MyProfileAbout(
                          int.parse(loadProfile!.postKarma.toString()),
                          int.parse(loadProfile.commentkarma.toString()),
                          loadProfile.description.toString())
                    ])),
    );
  }
}
