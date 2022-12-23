import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/typicons_icons.dart';
import '../models/comments_data.dart';
import '../providers/profile_provider.dart';
import '../widgets/loading_reddit.dart';

class MyProfileCommentWeb extends StatefulWidget {
  final ScrollController scrollController;
  final String userName;
  MyProfileCommentWeb(
      {Key? key, required this.userName, required this.scrollController})
      : super(key: key);
  @override
  State<MyProfileCommentWeb> createState() => _MyProfileCommentWebState();
}

class _MyProfileCommentWebState extends State<MyProfileCommentWeb> {
  int _page = 1;
  final int _limit = 25;
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  List<CommentsData>? commentsData;
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
       //=====================================this function is used to======================================//
  //=================Loading More Data====================//
  void loadMore() async {
    if (_isLoading == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        toggleLoadingMore(); // Display a progress indicator at the bottom
      });
      setState(() {
        _page += 1; // Increase _page by 1
      });

      try {
        await Provider.of<ProfileProvider>(context, listen: false)
            .fetchandSetProfileComments(widget.userName, _page, _limit, context)
            .then((_) async {
          commentsData =
              await Provider.of<ProfileProvider>(context, listen: false)
                  .gettingProfileComments;
        });
      } catch (err) {
        print('Something went wrong!');
      }

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
    _scrollController = ScrollController()..addListener(loadMore);
  }
 //=====================================this function is used to======================================//
  //=================Loading Data for first time====================//
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ProfileProvider>(context, listen: false)
          .fetchandSetProfileComments(widget.userName, _page, _limit, context)
          .then((value) async {
        commentsData =
            await Provider.of<ProfileProvider>(context, listen: false)
                .gettingProfileComments;
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
    return (_isLoading || _isLoadMoreRunning)
        ? const LoadingReddit()
        : (commentsData == null || commentsData!.isEmpty)
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
            : ListView(
                scrollDirection: Axis.vertical,
                controller: widget.scrollController,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) => InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              margin: EdgeInsets.all(20),
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
              );
  }
}
