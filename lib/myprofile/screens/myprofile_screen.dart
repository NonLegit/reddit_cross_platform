import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/myprofile_web.dart';
import '../widgets/myprofile_app.dart';
import '../models/myprofile_data.dart';
import '../providers/myprofile_provider.dart';
import '../../home/widgets/custom_upper_bar.dart';
import '../../home/controller/home_controller.dart';
import '../../createpost/controllers/posts_controllers.dart';
class MyProfileScreen extends StatefulWidget {
  static const routeName = '/myprofile';

  @override
  State<MyProfileScreen> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  //===================Loading data===============//
  var userName;
  var _isLoading = false;
  var _isInit = true;
  MyProfileData? loadProfile;
  //=============Tab Bar======================//
  TabController? _controller;
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
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        //labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
//=====================================================================================//
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
  // ===================================this function used to===========================================//
//==================fetch  date for First time===========================//
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      userName = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<MyProfileProvider>(context, listen: false)
          .fetchAndSetMyProfile(context)
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
  final HomeController controller = Get.put(
    HomeController(),
  );
  final PostController controllerForPost = Get.put(
    PostController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: ( kIsWeb)?PreferredSize(
                preferredSize: Size(700, 60),
                child: UpBar(controller: controller, controllerForCreatePost: controllerForPost,)):null,
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
