import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:flutter/material.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';

import '../../widgets/loading_reddit.dart';

class PostCard extends StatelessWidget {
  final String type;
  final String link;
  final String title;
  final bool isblured;
  final FlairId? flair;
  final bool nsfw;
  final bool spoiler;
  const PostCard({
    super.key,
    required this.type,
    required this.link,
    required this.title,
    this.isblured = false,
    required this.flair,
    required this.nsfw,
    required this.spoiler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostTagsAndTitle(
            flair: flair,
            isNSFW: nsfw,
            isSpoiler: spoiler,
            title: title,
          ),
          SizedBox(
            width: 100,
            height: 80,
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
      ),
    );
  }
}
