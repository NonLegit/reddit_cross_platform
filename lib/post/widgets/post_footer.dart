import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:intl/intl.dart';
import 'package:post/post/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

/// This Widget is responsible for the footer of the post.

class PostFooter extends StatefulWidget {
  /// the number of votes on the post;
  final int votes;

  /// the number of comments on the post
  final int comments;
  final int postVoteStatus;
  final String id;
  const PostFooter(
      {super.key,
      required this.votes,
      required this.comments,
      required this.postVoteStatus,
      required this.id});
  @override
  State<PostFooter> createState() =>
      _PostFooterState(postVoteStatus: postVoteStatus, votes: votes);
}

class _PostFooterState extends State<PostFooter> {
  int postVoteStatus;
  int votes;
  _PostFooterState({required this.postVoteStatus, required this.votes});

  upVote() {
    if (postVoteStatus != 1) {
      Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 1);
      setState(() {
        if (postVoteStatus == -1)
          votes = votes + 2;
        else
          ++votes;
        postVoteStatus = 1;
      });
    } else {
      Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 0);
      setState(() {
        postVoteStatus = 0;
        --votes;
      });
    }
    print('up voted');
  }

  downVote() {
    if (postVoteStatus != -1) {
      Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, -1);
      setState(() {
        if (postVoteStatus == 1)
          votes = votes - 2;
        else
          --votes;
        postVoteStatus = -1;
      });
    } else {
      Provider.of<PostProvider>(context, listen: false)
          .updateVotes(widget.id, 0);
      setState(() {
        postVoteStatus = 0;
        ++votes;
      });
    }
    print('down voted');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Material(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 10, end: 10),
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
                        padding: EdgeInsetsDirectional.all(8),
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
                        padding: EdgeInsetsDirectional.all(8),
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
                onTap: null,
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
