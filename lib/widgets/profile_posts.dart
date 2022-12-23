import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_header.dart';
import 'package:post/post/widgets/post_list.dart';
import 'package:post/widgets/loading_reddit.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';
import '../post/widgets/post_list.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../post/models/post_model.dart';

// import '..'
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
  int _page = 1;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }

//=====================================this function is used to======================================//
  //=================Loading Data for first time====================//
 
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchProfilePosts(widget.userName, 'Hot', _page, 25, context)
          .then((value) {
        posts = Provider.of<ProfileProvider>(context, listen: false)
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
    posts = Provider.of<ProfileProvider>(context, listen: true)
        .gettingProfilePostData;
    return (_isLoading || _isLoadMoreRunning)
        ? LoadingReddit()
        : (posts != null)
            ? PostList(
                topOfTheList: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: PostSortBottom(
                    page: _page,
                    type: 'User',
                    routeNamePop: widget.routeNamePop,
                    userName: widget.userName,
                  ),
                ),
                userName: widget.userName,
                updateData: _loadMore,
                data: posts as List<PostModel>,
                type: 'profile',
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
