import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:post/other_profile/models/others_profile_data.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/other_profile_web.dart';
import '../widgets/other_profile_app.dart';
import '../providers/other_profile_provider.dart';

class OthersProfileScreen extends StatefulWidget {
  static const routeName = '/OthersProfileScreen';

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen>
    with TickerProviderStateMixin {
  var _isLoading = false;
  var _isInit = true;
  // var myUserName = 'Zeinab-Moawad';
  // var otherUserName = 'zeinab-moawad';
  OtherProfileData? loadProfile;
  var userName;
  // = OtherProfileData(
  //     id: 0,
  //     userName: 'Zeinab-Moawad',
  //     email: 'email',
  //     profilePicture:
  //         'https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg',
  //     profileBackPicture:
  //         'https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac',
  //     description: 'I\'m student',
  //     displayName: 'Zeinab moawad',
  //     createdAt: '12/10/2022',
  //     numOfDaysInReddit: 2,
  //     followersCount: 2,
  //     postKarma: 1,
  //     isFollowed: false,
  //     commentkarma: 1);
  // ===================================================//
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'Comments'),
    const Tab(text: 'About'),
  ];
  List<Tab> tabsWeb = <Tab>[
    const Tab(text: 'OVERVIEW'),
    const Tab(text: 'Posts'),
    const Tab(text: 'Comments'),
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
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: (kIsWeb) ? 4 : 3, vsync: this);
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
      Provider.of<OtherProfileprovider>(context, listen: false)
          .fetchAndSetOtherProfile(userName)
          .then((value) {
        loadProfile = Provider.of<OtherProfileprovider>(context, listen: false)
            .gettingOtherProfileData;
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
    // final loadProfile = Provider.of<OtherProfileprovider>(context, listen: false)
    // .gettingOtherProfileData;
    return Scaffold(
      body: _isLoading
          ? LoadingReddit()
          : kIsWeb
              ? OtherProfileWeb(
                  tabBar: _tabBar,
                  loadProfile: loadProfile as OtherProfileData,
                  controller: _controller,
                  isLoading: _isLoading)
              : OtherProfileApp(
                  controller: _controller,
                  isLoading: _isLoading,
                  loadProfile: loadProfile as OtherProfileData,
                  tabBar: _tabBar,
                  userName: userName),
    );
  }
}
