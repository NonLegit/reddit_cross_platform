import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PostVideoInDiscover extends StatefulWidget {
  final VideoPlayerController videoController;
  final bool inView;
  const PostVideoInDiscover({
    super.key,
    required this.videoController,
    required this.inView,
  });

  @override
  State<PostVideoInDiscover> createState() => _PostVideoInDiscoverState();
}

class _PostVideoInDiscoverState extends State<PostVideoInDiscover> {
  late ChewieController chewieController;
  bool autoPlay = true;
  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoInitialize: true,
      autoPlay: false,
      looping: true,
      showControls: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inView && !widget.videoController.value.isPlaying && autoPlay) {
      {
        widget.videoController.play();
      }
    } else if (!widget.inView && widget.videoController.value.isPlaying) {
      {
        widget.videoController.pause();
        widget.videoController.seekTo(const Duration(seconds: 0));
      }
    }
    return Center(
      child: widget.videoController.value.isInitialized
          ? Container(
              margin:
                  const EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
              // height: (widget.videoController.value.size.height *
              //             (MediaQuery.of(context).size.width /
              //                 widget.videoController.value.size.width) <
              //         MediaQuery.of(context).size.height * .5)
              //     ? widget.videoController.value.size.height *
              //         (MediaQuery.of(context).size.width /
              //             widget.videoController.value.size.width)
              //     : MediaQuery.of(context).size.height * 0.5,
              // child: Align(
              //   alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: widget.videoController.value.aspectRatio,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
              //   ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }
}
