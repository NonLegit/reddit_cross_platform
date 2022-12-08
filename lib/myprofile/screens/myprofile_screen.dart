import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/myprofile_web.dart';
import '../widgets/myProfile_app.dart';
import '../models/myprofile_data.dart';
import '../providers/myprofile_provider.dart';

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
  MyProfileData? loadProfile;
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
  //=============Tab Bar======================//
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'Comments'),
    const Tab(text: 'About'),
  ];
  List<Tab> tabsWeb = <Tab>[
    const Tab(text: 'OVERVIEW'),
    const Tab(text: 'Posts'),
    const Tab(text: 'Comments'),
    const Tab(text: 'HISTORY'),
    const Tab(text: 'SAVED'),
    const Tab(text: 'HIDDEN'),
    const Tab(text: 'UPVOTED'),
    const Tab(text: 'DOWNVOTED'),
    const Tab(text: 'About'),
  ];
  TabBar get _tabBar => TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: (kIsWeb) ? tabsWeb : tabs,
        labelColor: Colors.black,
        labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  TabController? _controller;
  var userName;
  @override
  void initState() {
    // date= DateFormat.yMMMEd().format(toDay);
    super.initState();
    _controller = new TabController(length: (kIsWeb) ? 9 : 3, vsync: this);
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
      Provider.of<MyProfileProvider>(context, listen: false)
          .fetchAndSetMyProfile()
          .then((value) {
        loadProfile = Provider.of<MyProfileProvider>(context, listen: false)
            .gettingMyProfileData;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final loadProfile = Provider.of<MyProfileProvider>(context, listen: false)
    //     .gettingMyProfileData;
    return Scaffold(
        body: _isLoading
            ? LoadingReddit()
            : kIsWeb
                ? MyProfileWeb(
                    tabBar: _tabBar,
                    loadProfile: loadProfile as MyProfileData,
                    controller: _controller,
                    isLoading: _isLoading)
                : MyProfileApp(
                    controller: _controller,
                    isLoading: _isLoading,
                    loadProfile: loadProfile as MyProfileData,
                    tabBar: _tabBar,
                    userName: userName,
                  ));
  }
}
