import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:post/other_profile/models/others_profile_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/other_profile_web.dart';
import '../widgets/other_profile_app.dart';
import '../providers/other_profile_provider.dart';
import '../../home/widgets/custom_upper_bar.dart';
import '../../home/controller/home_controller.dart';
import '../../createpost/controllers/posts_controllers.dart';
class OthersProfileScreen extends StatefulWidget {
  static const routeName = '/OthersProfileScreen';

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen>
    with TickerProviderStateMixin {
  var _isLoading = false;
  var _isInit = true;
  OtherProfileData? loadProfile;
  var userName;
  // =========================TabBar==========================//
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
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //====================================================================================//
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
 // ===================================this function used to===========================================//
//==================fetch date for first time===========================//
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      userName = ModalRoute.of(context)?.settings.arguments as String;
      print(userName);
      Provider.of<OtherProfileprovider>(context, listen: false)
          .fetchAndSetOtherProfile(userName,context)
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
