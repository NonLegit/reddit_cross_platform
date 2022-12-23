import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/sort_bottom_web.dart';
import '../../models/subreddit_data.dart';
import '../widgets/subreddit_card_information_web.dart';
import '../../widgets/loading_reddit.dart';
import '../../post/models/post_model.dart';
import '../../post/widgets/post_list.dart';
import 'package:provider/provider.dart';
import '../../providers/subreddit_posts_provider.dart';

class SubredditePostWeb extends StatefulWidget {
  final SubredditData? loadedSubreddit;
  const SubredditePostWeb({
    Key? key,
    required this.loadedSubreddit,
  }) : super(key: key);
  @override
  State<SubredditePostWeb> createState() => _SubredditePostWebState();
}

class _SubredditePostWebState extends State<SubredditePostWeb> {
  int _page = 1;
  List<PostModel>? posts = [];
  bool _isLoadMoreRunning = false;
  String? userName;
  bool _isInit = true;
  bool _isLoading = false;
  late ScrollController _scrollController;
     //=====================================this function is used to======================================//
  //=================Loading More Data====================//
  void _loadMore() {
    if (_isLoading == false && _isLoadMoreRunning == false) {
      setState(() {
        toggleLoadingMore(); // Display a progress indicator at the bottom
      });
      setState(() {
        _page += 1;
      });
      // Increase _page by

      setState(() {
        toggleLoadingMore();
      });
    }
  }
 //=====================================this function is used to======================================//
  //=================Start loading More Data====================//
  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;
//=====================================this function is used to======================================//
  //=================Loading Data for first time====================//
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //New Hot Top
      await Provider.of<SubredditPostsProvider>(context, listen: false)
          .fetchSubredditePosts(widget.loadedSubreddit!.name.toString(), 'hot',
              _page, 25, context)
          .then((value) async {
        posts =
            await Provider.of<SubredditPostsProvider>(context, listen: false)
                .gettingSubredditPostData;
      });
      final prefs = await SharedPreferences.getInstance();
      userName = prefs.getString('userName');
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading || _isLoadMoreRunning)
        ? LoadingReddit()
        : (posts != null)
            ? PostList(
                leftMargin: 15.w,
                rightMargin: 35.w,
                topOfTheList: Container(
                  height: 65.h,
                  width: 50.h,
                  margin: EdgeInsets.only(left: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubredditCardInformationWeb(
                          loadedSubreddit: widget.loadedSubreddit),
                      SortBottomWeb(
                          page: 1,
                          userName: widget.loadedSubreddit!.name.toString()),
                    ],
                  ),
                ),
                userName: userName.toString(),
                updateData: _loadMore,
                data: posts as List<PostModel>,
                type: 'community',
              )
 
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const Icon(
                      Icons.reddit,
                      size: 100,
                    ),
                    const Text(
                      'Wow,such empty',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              );
  }
}
