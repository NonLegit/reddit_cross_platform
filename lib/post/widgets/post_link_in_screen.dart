import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';

import '../../widgets/loading_reddit.dart';
import '../models/post_model.dart';

class PostLinkInScreen extends StatelessWidget {
  final String type;
  final String link;
  final String title;
  final bool isblured;
  final FlairId? flair;
  final bool nsfw;
  final bool spoiler;
  const PostLinkInScreen(
      {super.key,
      required this.type,
      required this.link,
      required this.title,
      this.isblured = false,
      this.flair,
      required this.nsfw,
      required this.spoiler});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostTagsAndTitle(
          flair: flair,
          isNSFW: nsfw,
          isSpoiler: spoiler,
          title: title,
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
          child: LinkPreviewGenerator(
            showDescription: false,
            link: link,
            placeholderWidget: const LoadingReddit(),
            backgroundColor: Colors.black.withOpacity(0.6),
            showTitle: false,
            domainStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
