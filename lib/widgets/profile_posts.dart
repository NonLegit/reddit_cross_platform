import 'package:flutter/material.dart';
import 'package:post/widgets/loading_reddit.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';
import '../post/widgets/post.dart';
import 'package:provider/provider.dart';
import '../providers/profile_post_provider.dart';
import '../post/models/post_model.dart';

class ProfilePosts extends StatefulWidget {
  final String routeNamePop;
  final String userName;
//late ScrollController controller;
  ProfilePosts({
    Key? key,
    required this.routeNamePop,
    required this.userName,
    //required this.controller,
  }) : super(key: key);
  @override
  State<ProfilePosts> createState() => ProfilePostsState();
}

class ProfilePostsState extends State<ProfilePosts> {
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

  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '==============================inint profile Post======================');
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfilePostProvider>(context, listen: false)
          .fetchProfilePosts(widget.userName, 'Hot', _page, 25)
          .then((value) {
        posts = Provider.of<ProfilePostProvider>(context, listen: false)
            .gettingProfilePostData;
        setState(() {
          _isLoading = false;
        });
      });
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
    posts = Provider.of<ProfilePostProvider>(context, listen: true)
        .gettingProfilePostData;
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
                    type: 'User',
                    routeNamePop: widget.routeNamePop,
                    userName: widget.userName,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => Post.profile(
                            data: posts![index],
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
