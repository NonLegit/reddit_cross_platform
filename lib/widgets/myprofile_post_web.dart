import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import 'loading_reddit.dart';
import 'sort_bottom_web.dart';
import '../providers/profile_provider.dart';
import '../post/widgets/post_list.dart';

class MyProfilePostWeb extends StatefulWidget {
  final String userName;
  MyProfilePostWeb({Key? key, required this.userName}) : super(key: key);
  @override
  State<MyProfilePostWeb> createState() => _MyProfilePostWebState();
}

class _MyProfilePostWebState extends State<MyProfilePostWeb> {
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
  Widget build(BuildContext context) {
    posts = Provider.of<ProfileProvider>(context, listen: true)
        .gettingProfilePostData;
    return (_isLoading || _isLoadMoreRunning)
        ? LoadingReddit()
        : (posts != null)
            ?
            PostList(
                leftMargin: 15.w,
                rightMargin: 35.w,
                topOfTheList:Container(
                     height: 10.h,
                  width: 50.h,
                  margin: EdgeInsets.only(left: 15.w,right: 37.w),
                    child: SortBottomWeb(
                      page: _page,
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