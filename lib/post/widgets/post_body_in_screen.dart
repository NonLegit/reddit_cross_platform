import 'package:flutter/material.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/widgets/post_images_in_screen.dart';
import 'package:post/post/widgets/post_link_in_screen.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';
import 'package:post/post/widgets/post_video_in_widget_web.dart';
import 'package:video_player/video_player.dart';
import 'post_video_in_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// This Widget is responsible for the body of the post.

class PostBodyInScreen extends StatefulWidget {
  /// The data of the post
  final PostModel data;

  /// The user name
  final String userName;

  /// a boolean to check if in screen
  final bool inView;

  const PostBodyInScreen(
      {super.key,
      required this.data,
      required this.inView,
      required this.userName});

  @override
  State<PostBodyInScreen> createState() => _PostBodyInScreenState();
}

class _PostBodyInScreenState extends State<PostBodyInScreen> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsetsDirectional.only(bottom: 5),
        child: (widget.data.kind == 'self')
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
                      child: Html(
                        data: widget.data.text as String,
                      )
                      // child: Text(
                      //   widget.data.text as String,
                      //   style: TextStyle(
                      //     color: Theme.of(context).colorScheme.secondary,
                      //     fontSize: 14,
                      //   ),
                      //   textAlign: TextAlign.start,
                      //   //overflow: TextOverflow.ellipsis,
                      // ),
                      ),
                ],
              )
            : (widget.data.kind == 'image')
                ? PostImagesInScreen(
                    data: widget.data,
                    flair: widget.data.flairId,
                    nsfw: widget.data.nsfw as bool,
                    spoiler: widget.data.spoiler as bool,
                    title: widget.data.title as String,
                    imageNumber: widget.data.imageNumber,
                    links: widget.data.images!.cast<String>(),
                    maxHeightImageSize: widget.data.maxHeightImageSize as Size,
                  )
                : (widget.data.kind == 'link')
                    ? PostLinkInScreen(
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
    );
  }
}
