import 'package:flutter/material.dart';
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
import '../models/search_comment.dart';
import '../models/search_post.dart';
import './post_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import './empty_search.dart';

class CommentsList extends StatefulWidget {
  static const routeName = '/ommentsList';
  String quiry;
  int limit;
  SearchProvider provider;

  CommentsList(
      {Key? key, required this.limit, this.quiry = '', required this.provider})
      : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 0;
  int _page = 1;
  final int _limit = 25;
  bool isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;
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
                type: 'comments')
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '==============================inint profile Post======================');
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void didChangeDependencies() {
    if (widget.provider.initComments) {
      setState(() {
        fetchingDone = false;
      });
      widget.provider
          .getsearch(
              quiry: widget.quiry,
              limit: widget.limit,
              type: 'comments',
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
        : SingleChildScrollView(
            child: (widget.provider.searhComment!.data!.length == 0)
                ? EmptySearch(
                    message: 'there is no comments for \"${widget.quiry}\"')
                : ListView.builder(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      CommentData commentData =
                          widget.provider.searhComment!.data![index];
                      String commentDate = '';

                      final commentCreatedDate =
                          DateTime.parse(commentData.post!.createdAt as String);
                      // final createdDate = DateTime.parse('2022-12-06T08:55:28.000Z');
                      if (DateTime.now().year - commentCreatedDate.year > 0) {
                        commentDate =
                            '${DateTime.now().year - commentCreatedDate.year}yr';
                      } else if (DateTime.now().month -
                              commentCreatedDate.month >
                          0) {
                        commentDate =
                            '${DateTime.now().month - commentCreatedDate.month}mo';
                      } else if (DateTime.now().day - commentCreatedDate.day >
                          0) {
                        commentDate =
                            '${DateTime.now().day - commentCreatedDate.day}day';
                      } else if (DateTime.now().hour - commentCreatedDate.hour >
                          0) {
                        commentDate =
                            '${DateTime.now().hour - commentCreatedDate.hour}hr';
                      } else {
                        commentDate =
                            '${DateTime.now().minute - commentCreatedDate.minute}min';
                      }

                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, backgroundColor: Colors.white),
                          onPressed: () {
                            print('object');
                            // Navigator.of(context).pushNamed(SubredditScreen.routeName,
                            //     arguments: '${peopleData.fixedName}');
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PostView(
                                    postData: PostData.fromJson(
                                        commentData.post!.toJson())),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            Color.fromARGB(255, 228, 231, 239)),
                                    onPressed: () {
                                      // Navigator.of(context).pushNamed(SubredditScreen.routeName,
                                      //     arguments: '${peopleData.fixedName}');
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${commentData.author!.profilePicture}'),
                                            backgroundColor: Colors.black,
                                          ),
                                          title: Text(
                                              'u/${commentData.author!.displayName} . $commentDate '),
                                        ),
                                        // Text(
                                        //   commentData.text!,
                                        //   style: TextStyle(
                                        //     color: Colors.black,
                                        //   ),
                                        //   maxLines: 6,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        Html(
                                          data: jsonEncode(commentData.text!)
                                              .substring(
                                                  1,
                                                  jsonEncode(commentData.text!)
                                                          .length -
                                                      1),
                                          tagsList: Html.tags,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0, top: 10, bottom: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${commentData.votes} votes . ${commentData.repliesCount} replies ',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // child: Container(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${commentData.post!.votes} votes . ${commentData.post!.commentCount} comments ',
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
                    itemCount: widget.provider.searhComment!.data!.length,
                  ),
          );
  }
}
