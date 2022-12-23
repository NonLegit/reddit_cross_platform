import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:intl/intl.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../show_post/screens/show_post.dart';
import '../../show_post/screens/show_post_web.dart';

/// This Widget is responsible for the footer of the post.

class PostFooter extends StatefulWidget {
  /// the number of votes on the post;
  final int votes;

  /// the number of comments on the post
  final int comments;

  /// Check if it's a post created by the user
  final bool isMyPost;

  final int postVoteStatus;
  final String id;
  final PostModel data;
  final bool inScreen;
  final String userName;
  const PostFooter(
      {super.key,
      required this.votes,
      required this.comments,
      required this.postVoteStatus,
      required this.id,
      required this.isMyPost,
      required this.data,
      required this.inScreen,
      required this.userName});
  @override
  State<PostFooter> createState() =>
      _PostFooterState(postVoteStatus: postVoteStatus, votes: votes);
}

class _PostFooterState extends State<PostFooter> {
  int postVoteStatus;
  int votes;
  _PostFooterState({required this.postVoteStatus, required this.votes});

  upVote() async {
    if (postVoteStatus != 1) {
      if (await Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 1)) {
        setState(() {
          if (postVoteStatus == -1) {
            votes = votes + 2;
            widget.data.votes = (widget.data.votes! + 2);
          } else {
            ++votes;
            widget.data.votes = (widget.data.votes! + 1);
          }
          postVoteStatus = 1;
          widget.data.postVoteStatus = 1.toString();
        });
      }
    } else {
      if (await Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 0)) {
        setState(() {
          postVoteStatus = 0;
          widget.data.postVoteStatus = 0.toString();
          widget.data.votes = (widget.data.votes! - 1);
          --votes;
        });
      }
    }
  }

  downVote() async {
    if (postVoteStatus != -1) {
      if (await Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, -1)) {
        setState(() {
          if (postVoteStatus == 1) {
            votes = votes - 2;
            widget.data.votes = (widget.data.votes! - 2);
          } else {
            --votes;
            widget.data.votes = (widget.data.votes! - 1);
          }
          postVoteStatus = -1;
          widget.data.postVoteStatus = (-1).toString();
        });
      }
    } else {
      if (await Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 0)) {
        setState(() {
          postVoteStatus = 0;
          widget.data.postVoteStatus = 0.toString();

          ++votes;
          widget.data.votes = (widget.data.votes! + 1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Material(
        color: (!widget.inScreen && (widget.data.isSpam ?? false))
            ? Colors.blueGrey[50]
            : Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    highlightColor: Colors.orange[300],
                    focusColor: Colors.orange[300],
                    splashColor: Colors.orange[300],
                    hoverColor: Colors.orange[300],
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: upVote,
                    child: Tooltip(
                      message: 'Upvote',
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(8),
                        child: (postVoteStatus != 1)
                            ? Icon(
                                Typicons.up_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Typicons.up,
                                color: Colors.red[400],
                              ),
                      ),
                    ),
                  ),
                  Text(NumberFormat.compact().format(votes).toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  InkWell(
                    highlightColor: Colors.indigo[100],
                    focusColor: Colors.indigo[100],
                    splashColor: Colors.indigo[100],
                    hoverColor: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: downVote,
                    child: Tooltip(
                      message: 'Downvote',
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(8),
                        child: (postVoteStatus != -1)
                            ? Icon(
                                Typicons.down_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Typicons.down,
                                color: HexColor('#7192FE'),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: widget.inScreen
                    ? null
                    : () {
                        kIsWeb
                            ? Navigator.of(context).pushNamed(
                                ShowPostDetailsWeb.routeName,
                                arguments: {
                                    'data': widget.data,
                                    'userName': widget.userName
                                  })
                            // ? showDialog(
                            //     context: context,
                            //     builder: (context) => PostPopUpWeb(
                            //       data: widget.data,
                            //       userName: widget.userName,
                            //     ),
                            //   )
                            : Navigator.of(context).pushNamed(
                                ShowPostDetails.routeName,
                                arguments: {
                                    'data': widget.data,
                                    'userName': widget.userName
                                  });
                      },
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.comment_empty,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      (widget.comments > 0)
                          ? NumberFormat.compact()
                              .format(widget.comments)
                              .toString()
                          : 'Comment',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: null,
                child: Row(
                  children: [
                    Icon(
                      Icons.share_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
