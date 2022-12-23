import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/typicons_icons.dart';
import '../providers/Profile_provider.dart';
import '../myprofile/models/myprofile_data.dart';
import '../myprofile/widgets/myprofile_card_information_web.dart';
import '../widgets/loading_reddit.dart';
import '../widgets/sort_bottom_web.dart';

class OverviewMyProfileWeb extends StatefulWidget {
  final MyProfileData loadProfile;
  final ScrollController scrollController;
  final String type;
 OverviewMyProfileWeb(
      {Key? key, required this.loadProfile, required this.scrollController,required this.type})
      : super(key: key);
  @override
  State<OverviewMyProfileWeb> createState() => _OverviewMyProfileWebState();
}

class _OverviewMyProfileWebState extends State<OverviewMyProfileWeb> {
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
              'Hot',
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
    return ListView(
      scrollDirection: Axis.vertical,
      controller: widget.scrollController,
      children: [
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    height: 6.h,
                    width: 50.w,
                    margin: EdgeInsets.only(left: 100, bottom: 10, top: 30),
                    child: SortBottomWeb(
                        page: 1,
                        userName: widget.loadProfile.userName.toString()),
                    color: Colors.white,
                  ),
                  (_isLoading || _isLoadMoreRunning)
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
                          : SingleChildScrollView(
                              child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        margin: EdgeInsets.all(20),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        child: Column(
                                          children: [
                                            (commentsAndPosts![index]['type'] ==
                                                    'comment')
                                                ? ListTile(
                                                    title: Text(
                                                        commentsAndPosts![index]
                                                                ['data']
                                                            .title
                                                            .toString()),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${(commentsAndPosts![index]['data'].ownerType == 'User') ? 'u/' : 'r/'}${commentsAndPosts![index]['data'].owner}.${dateOfcomment(commentsAndPosts![index]['data'].createdAt.toString())} .${commentsAndPosts![index]['data'].votes}'),
                                                              const WidgetSpan(
                                                                  child: Icon(
                                                                Typicons.up,
                                                                size: 15,
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(commentsAndPosts![
                                                                index]['data']
                                                            .text
                                                            .toString()),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: 100,
                                                        bottom: 90,
                                                        top: 30),
                                                    height: 30.h,
                                                    width: 50.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: Colors.blue,
                                                          width: 3,
                                                        )),
                                                    child: Column(children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: const [
                                                            Expanded(
                                                              child: ListTile(
                                                                title: Text(
                                                                    'Post'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    )),
                                itemCount: commentsAndPosts?.length,
                              ),
                            )
                ],
              ),
            ),
            MyProfileCardInformationWeb(loadProfile: widget.loadProfile),
          ],
        ),
      ],
    );
  }
}
