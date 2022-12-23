import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';
import 'package:post/providers/global_settings.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../models/post_model.dart';

/// A widget to display a video in widget (web)

class PostVideoInWidgetWeb extends StatefulWidget {
  /// The url of the video
  final String url;

  /// The video controller

  final VideoPlayerController videoController;

  /// A boolean to check if in view

  final bool inView;

  /// The title of the post

  final String title;

  /// A boolean to determine if spoiler

  final bool spoiler;

  /// A boolean to determine if NSFW

  final bool nsfw;

  /// The flair data

  final FlairId? flair;
  const PostVideoInWidgetWeb({
    super.key,
    required this.url,
    required this.videoController,
    required this.inView,
    required this.title,
    required this.spoiler,
    required this.nsfw,
    required this.flair,
  });

  @override
  State<PostVideoInWidgetWeb> createState() => _PostVideoInWidgetWebState();
}

class _PostVideoInWidgetWebState extends State<PostVideoInWidgetWeb> {
  late ChewieController chewieController;
  bool isMuted = true;
  bool autoPlay = true;
  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoInitialize: true,
      autoPlay: false,
      looping: true,
      showControls: true,
      allowMuting: false,
      allowPlaybackSpeedChanging: true,
      placeholder: const LoadingReddit(),
    );
  }

  updateMuted() {
    if (Provider.of<GlobalSettings>(context, listen: false).getIsMuted) {
      widget.videoController.setVolume(0);
    } else {
      widget.videoController.setVolume(1);
    }
    setState(() {
      isMuted = Provider.of<GlobalSettings>(context, listen: false).getIsMuted;
    });
  }

  play() {
    if (Provider.of<GlobalSettings>(context, listen: false).getIsMuted) {
      widget.videoController.setVolume(0);
    } else {
      widget.videoController.setVolume(1);
    }
    widget.videoController.play();
    setState(() {
      isMuted = Provider.of<GlobalSettings>(context, listen: false).getIsMuted;
    });
  }

  toggleSound() {
    if (Provider.of<GlobalSettings>(context, listen: false).getIsMuted) {
      Provider.of<GlobalSettings>(context, listen: false).unMute();
      updateMuted();
    } else {
      Provider.of<GlobalSettings>(context, listen: false).mute();
      updateMuted();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inView && !widget.videoController.value.isPlaying && autoPlay) {
      {
        play();
      }
    } else if (!widget.inView && widget.videoController.value.isPlaying) {
      {
        widget.videoController.pause();
        widget.videoController.seekTo(const Duration(seconds: 0));
        updateMuted();
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostTagsAndTitle(
          flair: widget.flair,
          isSpoiler: widget.spoiler,
          isNSFW: widget.nsfw,
          title: widget.title,
        ),
        Center(
          child: widget.videoController.value.isInitialized
              ? Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 10),
                  height: (widget.videoController.value.size.height *
                              (MediaQuery.of(context).size.width /
                                  widget.videoController.value.size.width) <
                          MediaQuery.of(context).size.height * .5)
                      ? widget.videoController.value.size.height *
                          (MediaQuery.of(context).size.width /
                              widget.videoController.value.size.width)
                      : MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio:
                                  widget.videoController.value.aspectRatio,
                              child: Chewie(
                                controller: chewieController,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => toggleSound(),
                            child: Container(
                              margin: const EdgeInsetsDirectional.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  padding: const EdgeInsetsDirectional.all(2),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Icon(
                                    isMuted
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      !autoPlay
                          ? GestureDetector(
                              onTap: () {
                                autoPlay = true;
                                play();
                              },
                              child: Container(
                                margin: const EdgeInsetsDirectional.all(10),
                                child: const Icon(
                                  Icons.play_circle_outline_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }
}
