import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
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
        labelPadding:EdgeInsets.symmetric(horizontal: 18.w),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //==============================Loading Data===================================//
  var _isLoading = false;
  var _isInit = true;
  var subredditUserName;
SubredditData? loadedSubreddit;
//===============================================================================//
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
        endDrawer: _isLoading ? LoadingReddit() : endDrawer());
  }

 }
