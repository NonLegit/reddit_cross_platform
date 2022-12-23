import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import '../post/widgets/post.dart';
import 'loading_reddit.dart';
import 'sort_bottom_web.dart';
import '../myprofile/models/myprofile_data.dart';
import 'package:provider/provider.dart';
import '../providers/Profile_provider.dart';
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

  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;

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
            // Container(
            //   width: 50,
            //   padding:EdgeInsets.only(left: 30,right: 30) ,
            //   child: Column(
            //     children: [
            PostList(
                leftMargin: 15.w,
                rightMargin: 35.w,
                topOfTheList: Container(
                  margin: EdgeInsets.only(top: 10),
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
            //     ],
            //   ),
            // )
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
