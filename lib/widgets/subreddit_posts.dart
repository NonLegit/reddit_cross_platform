import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import '../providers/subreddit_post_provider.dart';
import 'post_sort_bottom.dart';
import '../post/widgets/post.dart';
import '../post/test_data.dart';

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
  int _page = 0;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? posts = [];
  late ScrollController _scrollController;
  void _loadMore() {
    if (_hasNextPage == true &&
        _isLoading == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      // Provider.of<SubredditPostProvider>(context, listen: false)
      //     .fetchSubredditePosts(widget.subredditName, 'hot', _page, 25)
      //     .then((value) {
      //   posts = Provider.of<SubredditPostProvider>(context, listen: false)
      //       .gettingSubredditPostData;
      setState(() {
        _isLoading = false;
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
    posts = Provider.of<SubredditPostProvider>(context, listen: true)
        .gettingSubredditPostData;
    return (_isLoading || _isLoadMoreRunning)
        ? LoadingReddit()
        : (posts != null)
            ? ListView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                children: [
                  PostSortBottom(
                      page: _page,
                      type: 'Subreddit',
                      routeNamePop: widget.routeNamePop,
                      userName: subredditName
                      //_dropDownValue, _icon
                      ),
                  //Select the type of Posts

                  SingleChildScrollView(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => Post.community(
                            data: posts![index],
                            inView: false,
                            updateDate: () {},
                          )),
                      itemCount: posts?.length,
                    ),
                  )
                ],
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
