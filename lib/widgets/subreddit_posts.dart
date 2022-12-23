import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import '../providers/subreddit_posts_provider.dart';
import 'post_sort_bottom.dart';

import '../post/widgets/post_list.dart';

class SubredditPosts extends StatefulWidget {
  final String routeNamePop;
  final String subredditName;
  SubredditPosts({
    Key? key,
    required this.routeNamePop,
    required this.subredditName,
  }) : super(key: key);
  @override
  State<SubredditPosts> createState() => _SubredditPosts();
}

class _SubredditPosts extends State<SubredditPosts> {
  int _page = 1;
  bool _hasNextPage = true;
  String? userName;
  bool _isLoadMoreRunning = false;
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? posts = [];
  late ScrollController _scrollController;
   //=====================================this function is used to======================================//
  //=================Loading More Data====================//
  
  void _loadMore() {
    if (_isLoading == false && _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      setState(() {
        _page += 1;
      });
      // Increase _page by

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMore);
  }
//=====================================this function is used to======================================//
  //=================Loading Data for first time====================//
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      userName=prefs.getString('userName');
      await Provider.of<SubredditPostsProvider >(context, listen: false)
          .fetchSubredditePosts(widget.subredditName, 'hot', _page, 25,context)
          .then((value) async {
        posts = await Provider.of<SubredditPostsProvider >(context, listen: false)
            .gettingSubredditPostData;
        setState(() {
          _isLoading = false;
        });
      });
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    posts = Provider.of<SubredditPostsProvider >(context, listen: true)
        .gettingSubredditPostData;
    return (_isLoading || _isLoadMoreRunning)
        ? LoadingReddit()
        : (posts == null || posts!.isEmpty)
            ? Center(
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
              )
            : PostList(
                topOfTheList: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: PostSortBottom(
                    page: _page,
                    type: 'Subreddit',
                    routeNamePop: widget.routeNamePop,
                    userName: widget.subredditName,
                  ),
                ),
                userName: userName.toString(),
                updateData: _loadMore,
                data: posts as List<PostModel>,
                type: 'community',
                );
  }
}
