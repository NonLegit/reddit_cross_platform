import 'package:flutter/material.dart';
import 'package:post/comments/widgets/comment_footer.dart';
import '../models/comment_model.dart';
import 'comment_body.dart';
import 'comment_header.dart';

/// A widget to display a comment in tree

class Comment extends StatefulWidget {
  /// The data of the commment
  final CommentModel data;

  /// The userName
  final String userName;

  /// The level of comment
  final int level;
  const Comment(
      {super.key, required this.data, required this.userName, this.level = 0});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool showReplies = false;
  @override
  Widget build(BuildContext context) {
    return widget.data.type != null
        ? const Text('more comments')
        : Container(
            margin: EdgeInsets.only(bottom: widget.level != 0 ? 0 : 10),
            child: Material(
              color: (false)
                  ? Colors.blueGrey[50]
                  : Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          for (int i = 0; i < widget.level; i++)
                            Container(
                              padding: const EdgeInsetsDirectional.only(end: 5),
                              child: const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          Flexible(
                            child: Column(
                              children: [
                                CommentHeader(
                                  authorIcon: widget.data.author?.profilePicture
                                      as String,
                                  authorName:
                                      widget.data.author?.userName as String,
                                  date: widget.data.createdAt as String,
                                  userName: widget.userName,
                                ),
                                CommentBody(
                                  userName: widget.userName,
                                  text: widget.data.text ?? '',
                                ),
                                CommentFooter(
                                  commentVoteStatus: 0,
                                  votes: widget.data.votes ?? 0,
                                  data: widget.data,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      showReplies = !showReplies;
                    });
                  },
                ),
                showReplies
                    ? Column(
                        children: (widget.data.replies ?? [])
                            .map((reply) => Comment(
                                  data: reply,
                                  userName: widget.userName,
                                  level: widget.level + 1,
                                ))
                            .toList())
                    : const SizedBox()
              ]),
            ),
          );
  }
}
