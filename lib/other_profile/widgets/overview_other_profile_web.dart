import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../../widgets/sort_bottom_web.dart';
import '../models/others_profile_data.dart';
import '../widgets/other_profile_card_information_web.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/loading_reddit.dart';
import '../../widgets/sort_bottom_web.dart';
import '../../post/widgets/post_comment_list.dart';

class OverviewOtherProfileWeb extends StatefulWidget {
  final OtherProfileData loadProfile;
  final ScrollController scrollController;
  OverviewOtherProfileWeb({
    Key? key,
    required this.scrollController,
    required this.loadProfile,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<OverviewOtherProfileWeb> createState() =>
      _OverviewOtherProfileWebState();
}

class _OverviewOtherProfileWebState extends State<OverviewOtherProfileWeb> {
  int _page = 1;
  final int _limit = 25;
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  List<Map<String, dynamic>>? commentsAndPosts;
  String dateOfcomment(String date) {
    final data1 = DateTime.parse(date);
    final date2 = DateTime.now();
    final difference = date2.difference(data1);
    final differenceMonth = date2.month - data1.month;
    final differenceYear = date2.year - data1.year;

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      final numOfWeeks = difference.inDays ~/ 7;
      if (numOfWeeks > 0) {
        return '${numOfWeeks}w';
      } else {
        return '${difference.inDays}d';
      }
    } else if (differenceYear > 0) {
      return '${differenceYear}y';
    } else {
      return '${differenceMonth}mon';
    }
  }

  ScrollController _scrollController = new ScrollController();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMore);
  }
 // ===================================this function used to===========================================//
//==================fetch date for first time===========================//
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //New Hot Top
      await Provider.of<ProfileProvider>(context, listen: false)
          .fetchandSetProfilePostsAndComments(
              widget.loadProfile.userName.toString(),
              'New',
              _page,
              _limit,
              context)
          .then((value) async {
        commentsAndPosts =
            await Provider.of<ProfileProvider>(context, listen: false)
                .gettingPostCommentData;
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
    commentsAndPosts = Provider.of<ProfileProvider>(context, listen: true)
        .gettingPostCommentData;
    return (_isLoading || _isLoadMoreRunning)
        ? const LoadingReddit()
        : (commentsAndPosts == null || commentsAndPosts!.isEmpty)
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    const Icon(
                      Icons.reddit,
                      size: 100,
                      color: Colors.black,
                    ),
                    const Text(
                      'Wow,such empty',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )
            : PostCommentList(
                leftMargin: 15.w,
                rightMargin: 35.w,
                topOfTheList: Container(
                  height: 80.h,
                  width: 50.h,
                  margin: EdgeInsets.only(left: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OtherProfileCardInformationWeb(
                          loadProfile: widget.loadProfile),
                      SortBottomWeb(
                          page: 1,
                          userName: widget.loadProfile.userName.toString()),
                    ],
                  ),
                ),
                userName: widget.loadProfile.userName.toString(),
                updateData: _loadMore,
                data: commentsAndPosts as List<Map<String, dynamic>>,
                type: 'Profile',
              );
  }
}
