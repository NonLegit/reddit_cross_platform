import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/widgets/post_card.dart';
import 'package:post/post/widgets/post_images.dart';
import 'package:post/post/widgets/post_images_web.dart';
import 'package:post/post/widgets/post_link_in_screen.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';
import 'package:post/post/widgets/post_video_in_widget_web.dart';
import 'package:video_player/video_player.dart';

import '../../show_post/screens/show_post.dart';
import '../../show_post/screens/show_post_web.dart';
import 'post_video_in_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// This Widget is responsible for the body of the post.

class PostBody extends StatefulWidget {
  final PostModel data;
  final String userName;
  final bool inView;

  const PostBody(
      {super.key,
      required this.data,
      required this.inView,
      required this.userName});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          kIsWeb
              ? Navigator.of(context).pushNamed(ShowPostDetailsWeb.routeName,
                  arguments: {'data': widget.data, 'userName': widget.userName})
              // ? showDialog(
              //     context: context,
              //     builder: (context) => PostPopUpWeb(
              //       data: widget.data,
              //       userName: widget.userName,
              //     ),
              //   )
              : Navigator.of(context).pushNamed(ShowPostDetails.routeName,
                  arguments: {
                      'data': widget.data,
                      'userName': widget.userName
                    });
        },
        child: Container(
          color: (widget.data.isSpam ?? false)
              ? Colors.blueGrey[50]
              : Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
          padding: const EdgeInsetsDirectional.only(bottom: 5),
          child: (widget.data.kind == 'self')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: PostTagsAndTitle(
                        flair: (widget.data.flairId),
                        isSpoiler: widget.data.spoiler as bool,
                        isNSFW: widget.data.nsfw as bool,
                        title: widget.data.title as String,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 10),
                      child: Text(
                        parse(widget.data.text as String)
                                .documentElement
                                ?.text ??
                            '',
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
                  ? kIsWeb
                      ? PostImagesWeb(
                          data: widget.data,
                          flair: widget.data.flairId,
                          nsfw: widget.data.nsfw as bool,
                          spoiler: widget.data.spoiler as bool,
                          title: widget.data.title as String,
                          imageNumber: widget.data.imageNumber,
                          links: widget.data.images!.cast<String>(),
                          maxHeightImageSize:
                              widget.data.maxHeightImageSize as Size,
                        )
                      : PostImages(
                          data: widget.data,
                          flair: widget.data.flairId,
                          nsfw: widget.data.nsfw as bool,
                          spoiler: widget.data.spoiler as bool,
                          title: widget.data.title as String,
                          imageNumber: widget.data.imageNumber,
                          links: widget.data.images!.cast<String>(),
                          maxHeightImageSize:
                              widget.data.maxHeightImageSize as Size,
                        )
                  : (widget.data.kind == 'link')
                      ? kIsWeb
                          ? PostLinkInScreen(
                              flair: widget.data.flairId,
                              nsfw: widget.data.nsfw as bool,
                              spoiler: widget.data.spoiler as bool,
                              link: widget.data.url as String,
                              title: widget.data.title as String,
                              type: widget.data.kind as String,
                            )
                          : PostCard(
                              flair: widget.data.flairId,
                              nsfw: widget.data.nsfw as bool,
                              spoiler: widget.data.spoiler as bool,
                              link: widget.data.url as String,
                              title: widget.data.title as String,
                              type: widget.data.kind as String,
                            )
                      : (widget.data.kind == 'video')
                          ? kIsWeb
                              ? PostVideoInWidgetWeb(
                                  title: widget.data.title as String,
                                  flair: widget.data.flairId,
                                  nsfw: widget.data.nsfw as bool,
                                  spoiler: widget.data.spoiler as bool,
                                  inView: widget.inView,
                                  url: widget.data.video as String,
                                  videoController: widget.data.videoController
                                      as VideoPlayerController,
                                )
                              : PostVideoInWidget(
                                  title: widget.data.title as String,
                                  flair: widget.data.flairId,
                                  nsfw: widget.data.nsfw as bool,
                                  spoiler: widget.data.spoiler as bool,
                                  inView: widget.inView,
                                  url: widget.data.video as String,
                                  videoController: widget.data.videoController
                                      as VideoPlayerController,
                                )
                          : const SizedBox(),
        ),
      ),
    );
  }
}
