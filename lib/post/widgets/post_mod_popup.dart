import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../provider/post_provider.dart';

class PostModPopUp extends StatefulWidget {
  final bool isApproved;
  final bool isNSFW;
  final bool isSpoiler;
  final bool isRemoved;
  final Function update;
  final bool isCommentsLocked;
  final PostModel data;
  const PostModPopUp(
      {super.key,
      required this.isApproved,
      required this.isNSFW,
      required this.isSpoiler,
      required this.update,
      required this.isCommentsLocked,
      required this.data,
      required this.isRemoved});

  @override
  State<PostModPopUp> createState() => _PostModPopUpState(
      isApproved, isNSFW, isSpoiler, isCommentsLocked, isRemoved);
}

class _PostModPopUpState extends State<PostModPopUp> {
  bool isApproved;
  bool isNSFW;
  bool isSpoiler;
  bool isRemoved;
  bool isCommentsLocked;
  _PostModPopUpState(this.isApproved, this.isNSFW, this.isSpoiler,
      this.isCommentsLocked, this.isRemoved);
  spoiler() async {
    if (await Provider.of<PostProvider>(context, listen: false).postAction(
        widget.data.sId as String, isSpoiler ? 'unspoiler' : 'spoiler')) {
      isSpoiler = !isSpoiler;
      widget.data.spoiler = isSpoiler;
      widget.update();
    }
  }

  nsfw() async {
    if (await Provider.of<PostProvider>(context, listen: false).postAction(
        widget.data.sId as String, isNSFW ? 'unmark_nsfw' : 'mark_nsfw')) {
      isNSFW = !isNSFW;
      widget.data.nsfw = isNSFW;
      widget.update();
    }
  }

  approve() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .postModerationAction(widget.data.sId as String, 'approve')) {
      widget.data.approved = true;
      isApproved = true;
      widget.update();
    }
  }

  remove() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .postModerationAction(widget.data.sId as String, 'remove')) {
      widget.data.removed = true;
      widget.update();
    }
  }

  spam() async {
    if (await Provider.of<PostProvider>(context, listen: false)
        .postModerationAction(widget.data.sId as String, 'spam')) {
      widget.data.isSpam = true;
      widget.update();
    }
  }

  comments() async {
    if (await Provider.of<PostProvider>(context, listen: false).postAction(
        widget.data.sId as String,
        isCommentsLocked ? 'unlock_comments' : 'lock_comments')) {
      isCommentsLocked = !isCommentsLocked;
      widget.data.locked = isCommentsLocked;
      widget.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Material(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                spoiler();
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 2, end: 5),
                      child: Icon(
                        MfgLabs.attention,
                        size: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      widget.isSpoiler ? 'Unmark spoiler' : 'Mark spoiler',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                nsfw();
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 2, end: 5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            FontAwesome.circle,
                            color: Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            size: 18,
                          ),
                          Text(
                            '18',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.brightness ==
                                            Brightness.light
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.surface,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Text(
                      widget.isNSFW ? 'Unmark NSFW' : 'Mark NSFW',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                comments();
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      widget.isCommentsLocked
                          ? 'UnLock comments'
                          : 'Lock comments',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        FontAwesome.mail,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Select post flair',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: widget.isRemoved
                  ? null
                  : () {
                      remove();
                      Navigator.pop(context);
                    },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        Icons.block_flipped,
                        color: widget.isRemoved
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    Text(
                      'Remove post',
                      style: TextStyle(
                        color: widget.isRemoved
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: widget.data.isSpam ?? false
                  ? null
                  : () {
                      spam();
                      Navigator.pop(context);
                    },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        Icons.block_flipped,
                        color: widget.data.isSpam ?? false
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    Text(
                      'Remove as spam',
                      style: TextStyle(
                        color: widget.isRemoved
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: widget.isApproved
                  ? null
                  : () {
                      approve();
                      Navigator.pop(context);
                    },
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        Icons.done,
                        color: widget.isApproved
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    Text(
                      'Approve post',
                      style: TextStyle(
                        color: widget.isApproved
                            ? Colors.grey[400]
                            : (Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
