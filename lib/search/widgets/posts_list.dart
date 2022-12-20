import 'package:flutter/material.dart';
import 'package:post/icons/arrow_head_down_word_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../provider/search_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logins/screens/login.dart';
import '../../logins/providers/authentication.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
import '../../widgets/custom_snack_bar.dart';
import '../models/search_post.dart';
import './post_view.dart';
import 'package:flutter_html/flutter_html.dart';
import './empty_search.dart';

class PostsList extends StatefulWidget {
  static const routeName = '/postslist';
  String quiry;
  SearchProvider provider;
  int limit;
  PostsList(
      {Key? key, required this.limit, this.quiry = '', required this.provider})
      : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  int _page = 1;
  final int _limit = 25;
  bool isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;
  /////////////
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 0;
  bool showNSFW = true;
  bool autoPlay = true;
  ScrollController _scrollController = new ScrollController();

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
        await widget.provider
            .getsearch(
                context: context,
                quiry: widget.quiry,
                page: _page,
                limit: widget.limit,
                withPage: true,
                type: 'posts')
            .then((_) async {});
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        toggleLoadingMore();
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.provider.initPost) {
      setState(() {
        fetchingDone = false;
      });
      widget.provider
          .getsearch(
              quiry: widget.quiry,
              limit: widget.limit,
              type: 'posts',
              context: context)
          .then((value) {
        if (widget.provider.isError) {}
        fetchingDone = true;

        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : (widget.provider.searhPost!.data!.length == 0)
            ? EmptySearch(message: 'there is no posts for \"${widget.quiry}\"')
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  PostData postData = widget.provider.searhPost!.data![index];
                  String date = '';
                  // if (index + 1 % widget.limit == 0) {
                  //   loadMore();
                  // }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.white),
                      onPressed: () {
                        // Navigator.of(context).pushNamed(SubredditScreen.routeName,
                        //     arguments: '${peopleData.fixedName}');
                      },
                      child: Column(mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PostView(
                              postData: postData,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${postData.votes} votes . ${postData.commentCount} comments ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 3,
                              thickness: 0,
                              endIndent: 0,
                              color: Colors.black,
                            ),
                          ]));
                },
                itemCount: widget.provider.searhPost!.data!.length,
              );
  }
}
