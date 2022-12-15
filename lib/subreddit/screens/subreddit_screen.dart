import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../home/controller/home_controller.dart';
import '../../models/subreddit_about _rules.dart';
import '../../icons/icon_broken.dart';
import '../models/subreddit_data.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../create_community/screens/create_community.dart';
import '../../widgets/loading_reddit.dart';
import '../widgets/subreddit_web.dart';
import '../widgets/subreddit_app.dart';
import '../providers/subreddit_provider.dart';
import '../../home/widgets/end_drawer.dart';
class SubredditScreen extends StatefulWidget {
  static const routeName = '/Subreddit';

  @override
  State<SubredditScreen> createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen>
    with TickerProviderStateMixin {
  //===============Drawer Bar=====================//
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
        labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //==================notification=========================//
  // String dropDownValue = "Low";
  // IconData icon = Icons.notifications;
  var _isLoading = false;
  var _isInit = true;
  //=========================================//
  var subredditUserName;
SubredditData? loadedSubreddit;
  // = SubredditData(
  //     id: 10,
  //     name: 'Cooking',
  //     subredditPicture:
  //         'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
  //     subredditBackPicture:
  //         'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-750%2Fd30%2Feasy-basic-pancakes-horiz-1022%2Feasy-basic-pancakes-horiz-1022_0.jpg%3Fitok%3DXQMZkp_j',
  //     description: 'I\'m Chef',
  //     subredditLink:
  //         'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
  //     numOfMembers: 10398,
  //     numOfOnlines: 1789,
  //     rules: [
  //       SubredditAboutRules('no codeing', 'i hate coding'),
  //       SubredditAboutRules('no codeing', 'i hate cod'),
  //       SubredditAboutRules('no codeing', 'i hate code'),
  //       SubredditAboutRules('no codeing', 'i hate code')
  //     ],
  //     moderators: ['Ali', 'omer', 'zeinab', 'mazen'],
  //     isJoined: true);
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================doing fetch=======================================//
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      subredditUserName = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<SubredditProvider>(context, listen: false)
          .fetchAndSetSubredddit(subredditUserName)
          .then((value) {
        loadedSubreddit = Provider.of<SubredditProvider>(context, listen: false)
            .gettingSubredditeData;
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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? LoadingReddit()
            : kIsWeb
                ? SubredditWeb(
                    loadedSubreddit: loadedSubreddit,
                    userName: subredditUserName,
                    controller: _controller,
                    isLoading: _isLoading,
                    tabBar: _tabBar,
                  )
                : SubredditApp(
                    controller: _controller,
                    isLoading: _isLoading,
                    tabBar: _tabBar,
                    loadedSubreddit: loadedSubreddit as SubredditData,
                    userName: subredditUserName),
        endDrawer: _isLoading ? LoadingReddit() : endDrawer(controller: controller,));
  }

 }
