import 'package:flutter/material.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';

import '../models/comment_model.dart';
import '../providers/comments_provider.dart';
import 'comment.dart';

/// This widget displays the comments tree of a post

class CommentsList extends StatefulWidget {
  /// The ID of the post to get its comments

  final String postId;

  /// The user name

  final String userName;
  const CommentsList({super.key, required this.postId, required this.userName});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  bool _isInit = true;
  bool _isLoading = false;
  List<CommentModel>? commentsData = [];
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PostCommentsProvider>(context, listen: false)
          .fetchPostComments(widget.postId, 10, 10)
          .then((value) {
        commentsData = Provider.of<PostCommentsProvider>(context, listen: false)
            .gettingPostComments;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingReddit()
        : Column(
            children: commentsData
                ?.map(
                  (reply) => Comment(
                    data: reply,
                    userName: widget.userName,
                  ),
                )
                .toList() as List<Comment>);
  }
}
