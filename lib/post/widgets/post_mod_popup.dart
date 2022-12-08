import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:post/other_profile/screens/others_profile_screen.dart';

class PostModPopUp extends StatefulWidget {
  final bool isApproved;
  final bool isNSFW;
  final bool isSpoiler;
  final Function approve;
  final Function nsfw;
  final Function spoiler;
  const PostModPopUp(
      {required this.isApproved,
      required this.approve,
      required this.isNSFW,
      required this.isSpoiler,
      required this.nsfw,
      required this.spoiler});

  @override
  State<PostModPopUp> createState() => _PostModPopUpState();
}

class _PostModPopUpState extends State<PostModPopUp> {
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
                widget.spoiler();
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
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
                widget.nsfw();
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
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
              onTap: null,
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        FontAwesome.mail,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Lock comments',
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
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
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
              onTap: null,
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        FontAwesome.mail,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Remove post',
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
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
                      child: Icon(
                        FontAwesome.mail,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Remove as spam',
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
              onTap: widget.isApproved
                  ? null
                  : () {
                      widget.approve();
                      Navigator.pop(context);
                    },
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5),
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
