import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

/// This Widget is responsible for the footer of the post.

class PostFooter extends StatefulWidget {
  /// the number of votes on the post;
  final int votes;
  /// the number of comments on the post
  final int comments;
  const PostFooter({super.key, required this.votes, required this.comments});
  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Typicons.up_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text((widget.votes > 0) ? widget.votes.toString() : 'Vote',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Typicons.down_outline,
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
