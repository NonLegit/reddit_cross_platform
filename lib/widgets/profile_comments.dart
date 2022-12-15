import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:flutter/material.dart';
import '../providers/profile_comments_provider.dart';
import '../models/comments_data.dart';
import '../widgets/loading_reddit.dart';

//import 'package:flutter_code_style/analysis_options.yaml';
class ProfileComments extends StatefulWidget {
  final String userName;
  ProfileComments({required this.userName});
  @override
  State<ProfileComments> createState() => ProfileCommentsState();
}

class ProfileCommentsState extends State<ProfileComments> {
  int _page = 0;
  final int _limit = 25;
  bool _hasNextPage = true;
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  List<CommentsData>? commentsData = [
    CommentsData(
        title: 'title',
        owner: 'owner',
        createdAt: '2022-09-24T14:15:22Z',
        votes: 3,
        text: 'text',
        ownerType: 'User'),
    CommentsData(
        title: 'title',
        owner: 'owner',
        createdAt: '2021-08-24T14:15:22Z',
        votes: 3,
        text: 'text',
        ownerType: 'Subreddit'),
    CommentsData(
        title: 'title',
        owner: 'owner',
        createdAt: '2022-11-24T14:15:22Z',
        votes: 3,
        text:
            'textkoijhuytdrrrrrrrrrrooooooooohvgxsedssssssssssgfhhhhhhhhhhjjjjjjoooooo',
        ownerType: 'Subreddit'),
    CommentsData(
        title: 'title',
        owner: 'owner',
        createdAt: '2019-08-24T14:15:22Z',
        votes: 3,
        text: 'text',
        ownerType: 'User')
  ];
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
  bool loadMore() {
  //   if (_hasNextPage == true &&
  //       _isLoading == false &&
  //       _isLoadMoreRunning == false &&
  //       _scrollController.position.extentAfter < 300) {
  //     setState(() {
  //       toggleLoadingMore(); // Display a progress indicator at the bottom
  //     });

  //     _page += 1; // Increase _page by 1

      // try {
      //   Provider.of<ProfileCommentsProvider>(context, listen: false)
      //       .fetchandSetProfileComments(widget.userName, _page, _limit)
      //       .then((value) {
      //     commentsData =
      //         Provider.of<ProfileCommentsProvider>(context, listen: false)
      //             .gettingProfileComments;
      //     if (commentsData == null) {
      //       setState(() {
      //         _hasNextPage = false;
      //       });
      //     }
      //   });
      // } catch (err) {
      //   print('Something went wrong!');
      // }

    //   setState(() {
    //     toggleLoadingMore();
    //   });
    //   return _isLoadMoreRunning;
    // }
     return _isLoadMoreRunning;
  }

  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '==============================inint profile Post======================');
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   Provider.of<ProfileCommentsProvider>(context, listen: false)
    //       .fetchandSetProfileComments(widget.userName,_page,_limit)
    //       .then((value) {
    //     commentsData =
    //         Provider.of<ProfileCommentsProvider>(context, listen: false)
    //             .gettingProfileComments;
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading || _isLoadMoreRunning)
        ? const LoadingReddit()
        : (commentsData != null)
            ? ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) => InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              // height: 15.h,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        commentsData![index].title.toString()),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${(commentsData![index].ownerType == 'User') ? 'u/' : 'r/'}${commentsData![index].owner}.${dateOfcomment(commentsData![index].createdAt.toString())} .${commentsData![index].votes}'),
                                              const WidgetSpan(
                                                  child: Icon(
                                                Typicons.up,
                                                size: 15,
                                              )),
                                            ],
                                          ),
                                        ),
                                        Text(commentsData![index]
                                            .text
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                            onTap: () {},
                          )),
                      itemCount: commentsData?.length,
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
