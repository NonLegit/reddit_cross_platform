import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:post/post/provider/post_provider.dart';
import 'package:provider/provider.dart';

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
    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: upVote,
                icon: (postVoteStatus != 1)
                    ? Icon(
                        Typicons.up_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : Icon(
                        Typicons.up,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
              ),
              Text(votes.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              IconButton(
                onPressed: downVote,
                icon: (postVoteStatus != -1)
                    ? Icon(
                        Typicons.down_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : Icon(
                        Typicons.down,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(
              FontAwesome.comment_empty,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: Text(
              (widget.comments > 0) ? widget.comments.toString() : 'Comment',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: Text('Share',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }
}
