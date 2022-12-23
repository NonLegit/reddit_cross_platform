import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:post/post/models/post_model.dart';

/// This widget displays the title and the spoiler and NSFW tags

class PostTagsAndTitle extends StatefulWidget {
  /// The title of the post
  final String title;

  /// A boolean to determine if NSFW

  final bool isNSFW;

  /// A boolean to determine if spoiler

  final bool isSpoiler;

  /// The flair data

  final FlairId? flair;

  const PostTagsAndTitle(
      {super.key,
      required this.title,
      required this.isNSFW,
      required this.isSpoiler,
      required this.flair});

  @override
  State<PostTagsAndTitle> createState() => _PostTagsAndTitleState();
}

class _PostTagsAndTitleState extends State<PostTagsAndTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isNSFW || widget.isSpoiler)
          Container(
            padding: const EdgeInsetsDirectional.only(bottom: 10, start: 15),
            child: Row(
              children: [
                if (widget.isNSFW)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(
                            FontAwesome.circle,
                            color: Colors.red,
                            size: 18,
                          ),
                          Text(
                            '18',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Text(
                        'NSFW',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                if (widget.isSpoiler)
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: (widget.isNSFW) ? 15 : 0),
                    child: Row(
                      children: [
                        Icon(
                          MfgLabs.attention,
                          size: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          'Spoiler',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsetsDirectional.only(start: 15, end: 10),
          child: Text(
            widget.title,
            style: TextStyle(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
          ),
        ),
        if (widget.flair != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor(widget.flair?.backgroundColor as String),
            ),
            padding: const EdgeInsetsDirectional.only(
                start: 10, end: 10, top: 5, bottom: 5),
            margin:
                const EdgeInsetsDirectional.only(top: 10, start: 15, end: 10),
            child: Text(
              widget.flair?.text as String,
              style: TextStyle(
                  fontSize: 12,
                  color: HexColor(widget.flair?.textColor as String),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
      ],
    );
  }
}
