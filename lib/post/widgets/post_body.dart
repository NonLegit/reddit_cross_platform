import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:blur/blur.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/widgets/post_card.dart';
import 'package:post/post/widgets/post_images.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/loading_reddit.dart';
import '../network/fetch_preview.dart';
import '../network/open_link.dart';
import '../network/prepare_images.dart';
import 'post_video_in_widget.dart';

/// This Widget is responsible for the body of the post.

class PostBody extends StatefulWidget {
  final PostModel data;
  final Function updateImageNumber;
  final bool inView;

  const PostBody(
      {super.key,
      required this.data,
      required this.updateImageNumber,
      required this.inView});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsetsDirectional.only(bottom: 5),
        child: (widget.data.kind == 'text')
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostTagsAndTitle(
                    flair: (widget.data.flairId),
                    isSpoiler: widget.data.spoiler as bool,
                    isNSFW: widget.data.nsfw as bool,
                    title: widget.data.title as String,
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                        start: 10, end: 10, top: 10),
                    child: Text(
                      widget.data.text as String,
                      maxLines: 3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : (widget.data.kind == 'image')
                ? PostImages(
                    flair: widget.data.flairId ,
                    nsfw: widget.data.nsfw as bool,
                    spoiler: widget.data.spoiler as bool,
                    title: widget.data.title as String,
                    imageNumber: widget.data.imageNumber,
                    links: widget.data.images!.cast<String>(),
                    maxHeightImageSize: widget.data.maxHeightImageSize as Size,
                    updateImageNumber: widget.updateImageNumber,
                  )
                : (widget.data.kind == 'link')
                    ? PostCard(
                        flair: widget.data.flairId  ,
                        nsfw: widget.data.nsfw as bool,
                        spoiler: widget.data.spoiler as bool,
                        link: widget.data.url as String,
                        title: widget.data.title as String,
                        type: widget.data.kind as String,
                      )
                    : (widget.data.kind == 'video')
                        ? PostVideoInWidget(
                            title: widget.data.title as String,
                            flair: widget.data.flairId  ,
                            nsfw: widget.data.nsfw as bool,
                            spoiler: widget.data.spoiler as bool,
                            inView: widget.inView,
                            url: widget.data.video as String,
                            videoController: widget.data.videoController
                                as VideoPlayerController,
                          )
                        : const SizedBox(),
      ),
    );
  }
}
