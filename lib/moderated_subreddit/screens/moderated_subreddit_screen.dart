import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';
import '../widgets/moderated_subreddit_web.dart';
import '../../models/subreddit_data.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/moderated_subreddit_app.dart';
import '../providers/moderated_subreddit_provider.dart';
import '../../home/widgets/end_drawer.dart';
import '../../home/controller/home_controller.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../home/widgets/custom_upper_bar.dart';
class ModeratedSubredditScreen extends StatefulWidget {
  static const routeName = '/moderatedsubreddit';
  @override
  State<ModeratedSubredditScreen> createState() =>
      _ModeratedSubredditScreenState();
}

class _ModeratedSubredditScreenState extends State<ModeratedSubredditScreen>
    with TickerProviderStateMixin {
  //================Loading Data===================================//
  var _isLoading = false;
  var _isInit = true;
  var subredditUserName;
SubredditData? loadedSubreddit;

  //=====================End Drawer=============//
  bool isOnline = true;
  final HomeController controller = Get.put(
    HomeController(),
  );
  //================Tab bar==================//
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'About'),
  ];
  TabController? _controller;
  TabBar get _tabBar => TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: tabs,
        labelColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(horizontal: 18.w),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //==============================================================//
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
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
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      subredditUserName = ModalRoute.of(context)?.settings.arguments as String;
      print(subredditUserName);
      Provider.of<ModeratedSubredditProvider>(context, listen: false)
          .fetchAndSetModeratedSubredddit(subredditUserName,context)
          .then((value) {
        loadedSubreddit =
            Provider.of<ModeratedSubredditProvider>(context, listen: false)
                .gettingSubredditeData;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  final HomeController controllerHome = Get.put(
    HomeController(),
  );
  final PostController controllerForPost = Get.put(
    PostController(),
  );
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
          appBar: ( kIsWeb)?PreferredSize(
                preferredSize: Size(700, 60),
                child: UpBar(controller: controllerHome, controllerForCreatePost: controllerForPost,)):null,
        body: _isLoading
            ? LoadingReddit()
            : kIsWeb
                ? ModeratedSubredditWeb(
                    loadedSubreddit: loadedSubreddit,
                    userName: subredditUserName,
                    controller: _controller,
                    isLoading: _isLoading,
                    tabBar: _tabBar,
                  )
                : ModeratedSubredditApp(
                    userName: subredditUserName,
                    loadedSubreddit: loadedSubreddit,
                    controller: _controller,
                    isLoading: _isLoading,
                    tabBar: _tabBar),
        endDrawer:
            _isLoading ? LoadingReddit() : endDrawer(controller: controller));
  }
}
