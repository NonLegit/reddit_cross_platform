import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_mod_popup.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../provider/post_provider.dart';

/// This widget displays the moderator tools of the post

class PostModTools extends StatefulWidget {
  /// Check if it's a post created by the user
  final bool isMyPost;

  /// A boolean to determine if the post is approved

  final bool isApproved;

  /// A boolean to determine if the post is NSFW

  final bool isNSFW;

  /// A boolean to determine if the post is spoiler

  final bool isSpoiler;

  /// A boolean to determine if the comments of the post is locked

  final bool isCommentsLocked;

  /// A boolean to determine if the post is removed

  final bool isRemoved;

  /// A function which is invoked when the state changes

  final Function update;

  /// The post data
  final PostModel data;

  /// A boolean to check if in screen
  final bool inScreen;

  const PostModTools({
    super.key,
    required this.isApproved,
    required this.isNSFW,
    required this.isSpoiler,
    required this.update,
    required this.data,
    required this.isMyPost,
    required this.isCommentsLocked,
    required this.isRemoved,
    required this.inScreen,
  });

  @override
  State<PostModTools> createState() =>
      _PostModTools(isApproved, isNSFW, isSpoiler, isCommentsLocked);
}

class _PostModTools extends State<PostModTools> {
  bool isApproved;
  bool isNSFW;
  bool isSpoiler;
  bool isCommentsLocked;
  _PostModTools(
      this.isApproved, this.isNSFW, this.isSpoiler, this.isCommentsLocked);
  approve() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .postModerationAction(widget.data.sId as String, 'approve')) {
      widget.data.approved = true;
      isApproved = true;
      widget.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 2),
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
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: isApproved ? null : approve,
                    child: Tooltip(
                      message: 'Approve',
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(10),
                        child: (!widget.isApproved)
                            ? Icon(
                                Icons.done,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Icons.done,
                                color: Colors.green[500],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(25.0),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => PostModPopUp(
                        isRemoved: widget.isRemoved,
                        data: widget.data,
                        isApproved: widget.isApproved,
                        update: widget.update,
                        isNSFW: widget.isNSFW,
                        isSpoiler: widget.isSpoiler,
                        isCommentsLocked: widget.isCommentsLocked),
                  );
                },
                child: Tooltip(
                  message: 'More options',
                  child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Icon(
                        Icons.format_list_bulleted,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
