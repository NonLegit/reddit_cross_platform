import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:post/post/models/post_model.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';

/// This widget shows the popup menu of the widget

class PostPopupMenu extends StatefulWidget {
  /// A boolean to determine if the post is saved
  final bool isSaved;

  /// The post data
  final PostModel data;

  /// A function which is invoked when the state changes
  final Function update;

  /// A boolean to determine if it's the user's post
  final bool isMyPost;
  const PostPopupMenu(
      {super.key,
      required this.isSaved,
      required this.data,
      required this.update,
      required this.isMyPost});

  @override
  State<PostPopupMenu> createState() => _PostPopupMenuState(isSaved);
}

class _PostPopupMenuState extends State<PostPopupMenu> {
  bool isSaved;

  _PostPopupMenuState(this.isSaved);

  save() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .savePost(widget.data.sId as String)) {
      widget.data.isSaved = true;
      isSaved = true;
      widget.update();
    }
  }

  unSave() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .unSavePost(widget.data.sId as String)) {
      widget.data.isSaved = false;
      isSaved = false;
      widget.update();
    }
  }

  delete() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .deletePost(widget.data.sId as String)) {
      widget.data.isDeleted;
      widget.update();
    }
  }

  report() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .reportSpam(widget.data.sId as String)) {
      print('spam');
    }
  }

  block() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: 5),
      child: PopupMenuButton(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                ),
                Text(
                  isSaved ? 'Unsave' : 'Save',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: const Icon(Icons.share_outlined),
                ),
                Text(
                  'Share',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (widget.isMyPost)
            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: const Icon(Icons.delete_outline_rounded),
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          if (!widget.isMyPost)
            PopupMenuItem(
              value: 4,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: const Icon(Icons.flag_outlined),
                  ),
                  Text(
                    'Report as spam',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          if (!widget.isMyPost)
            PopupMenuItem(
              value: 5,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: const Icon(Typicons.block),
                  ),
                  Text(
                    'Block account',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        ],
        onSelected: ((value) {
          if (value == 1) {
            isSaved ? unSave() : save();
          } else if (value == 2) {
          } else if (value == 3) {
            delete();
          } else if (value == 4) {
            report();
          } else if (value == 5) {
            block();
          }
        }),
        child: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
