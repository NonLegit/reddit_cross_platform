import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PostVideoInDiscover extends StatefulWidget {
  final String url;
  final double height;
  final bool inView;
  const PostVideoInDiscover(
      {super.key,
      required this.url,
      required this.inView,
      required this.height});

  @override
  State<PostVideoInDiscover> createState() => _PostVideoInDiscoverState();
}

class _PostVideoInDiscoverState extends State<PostVideoInDiscover> {
  late ChewieController chewieController;
  bool autoPlay = true;
  late VideoPlayerController videoPlayerController;
    //=====================================this function is used to======================================//
  //=================initilize Video====================//
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url);

    videoPlayerController.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        autoPlay: false,
        looping: true,
        showControls: false,
      );
      setState(() {});
    });
    videoPlayerController.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inView && !videoPlayerController.value.isPlaying && autoPlay) {
      {
        videoPlayerController.play();
      }
    } else if (!widget.inView && videoPlayerController.value.isPlaying) {
      {
        videoPlayerController.pause();
        videoPlayerController.seekTo(const Duration(seconds: 0));
      }
    }
    return Center(
      child: videoPlayerController.value.isInitialized
          ? Container(
              height: widget.height,
              width: 100.w,
              child: AspectRatio(
                aspectRatio: 100.w / widget.height,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
