import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../providers/discover_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/post_video_in_discover.dart';
import '../models/discover_data.dart';
import '../../screens/emptyscreen.dart';
import '../../show_post/screens/show_post.dart';

class GridViewDiscover extends StatefulWidget {
  String topic;

  GridViewDiscover({
    super.key,
    required this.topic,
  });

  @override
  State<GridViewDiscover> createState() => _GridViewDiscoverState();
}

class _GridViewDiscoverState extends State<GridViewDiscover> {
  DiscoverData? imgAndVideoList;
  int _page = 1;
  final int _limit = 25;
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  ScrollController _scrollController = new ScrollController();
  var userName;
  //=====================================this function is used to======================================//
  //=================Loading More Data====================//
  void loadMore() async {
    if (_isLoading == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        toggleLoadingMore(); // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        await Provider.of<DiscoverProvider>(context, listen: false)
            .fetchAndSetDiscover(widget.topic, _page, _limit, context)
            .then((value) async {
          imgAndVideoList =
              await Provider.of<DiscoverProvider>(context, listen: false)
                  .gettingImagesAndVideo;
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
 //=====================================this function is used to======================================//
  //=================Loading Data for first time====================//
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      userName = prefs.getString('userName');
      await Provider.of<DiscoverProvider>(context, listen: false)
          .fetchAndSetDiscover(widget.topic, _page, _limit, context)
          .then((value) async {
        imgAndVideoList =
            await Provider.of<DiscoverProvider>(context, listen: false)
                .gettingImagesAndVideo;
        print(imgAndVideoList);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    //==================================================//
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading || _isLoadMoreRunning)
        ? const LoadingReddit()
        : (imgAndVideoList != null)
            ? MasonryGridView.count(
                controller: _scrollController,
                itemCount: imgAndVideoList!.imgAndVideoList!.length,
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        imgAndVideoList!.imgAndVideoList![index]['Url']!
                                .contains(".mp4")
                            ? EmptyScreen()
                            : Navigator.of(context).pushNamed(
                                ShowPostDetails.routeName,
                                arguments: {
                                    'data': imgAndVideoList!.allPosts![index],
                                    'userName': userName
                                  });
                      },
                      child: Stack(children: [
                        imgAndVideoList!.imgAndVideoList![index]['Url']!
                                .contains(".mp4")
                            ? Container(
                                child: Container(
                                  foregroundDecoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0, 1],
                                    ),
                                  ),
                                  decoration: BoxDecoration(),
                                  margin: const EdgeInsets.all(10),
                                  child: PostVideoInDiscover(
                                      height: Random().nextInt(150) + 150.5,
                                      inView: true,
                                      url: imgAndVideoList!
                                          .imgAndVideoList![index]['Url']!),
                                ),
                              )
                            : Container(
                                foregroundDecoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0, 1],
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10, top: 10),
                                height: Random().nextInt(150) + 150.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(imgAndVideoList!
                                          .imgAndVideoList![index]['Url']!)),
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0)),
                                )),
                        Positioned(
                            top: 5.h,
                            left: 10.w,
                            child: Container(
                                child: Text(
                              'r/${imgAndVideoList!.imgAndVideoList![index]['subredditName']!}',
                              style: TextStyle(color: Colors.white),
                            )))
                      ]));
                })
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
