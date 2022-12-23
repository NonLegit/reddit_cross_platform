import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:post/post/models/post_model.dart';
import 'package:post/post/widgets/post_tags_and_title.dart';
import 'package:post/widgets/loading_reddit.dart';

class PostImagesWeb extends StatefulWidget {
  final PostModel data;
  final List<String> links;
  final Size maxHeightImageSize;
  final int imageNumber;
  final String title;
  final bool spoiler;
  final bool nsfw;
  final FlairId? flair;
  const PostImagesWeb({
    super.key,
    required this.links,
    required this.maxHeightImageSize,
    required this.imageNumber,
    required this.title,
    required this.spoiler,
    required this.nsfw,
    required this.flair,
    required this.data,
  });

  @override
  State<PostImagesWeb> createState() => _PostImagesWebState(imageNumber);
}

class _PostImagesWebState extends State<PostImagesWeb> {
  int imageNumber;
  bool imageCounterVisible = false;
  late List<CachedNetworkImage> images;
  _PostImagesWebState(this.imageNumber);

  void updateImageNumber(value) => setState(() {
        imageNumber = value;
        widget.data.imageNumber = value;
        imageCounterVisible = true;
        var timer;
        timer = Timer(const Duration(milliseconds: 3000), () {
          if (!mounted) {
            timer.cancel();
          } else {
            setState(() {
              imageCounterVisible = false;
            });
          }
        });
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostTagsAndTitle(
          flair: widget.flair,
          isSpoiler: widget.spoiler,
          isNSFW: widget.nsfw,
          title: widget.title,
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ImageSlideshow(
                    initialPage: imageNumber,
                    height: !(widget.maxHeightImageSize.height *
                                (MediaQuery.of(context).size.width /
                                    widget.maxHeightImageSize.width))
                            .isNaN
                        ? (widget.maxHeightImageSize.height *
                                    (MediaQuery.of(context).size.width /
                                        widget.maxHeightImageSize.width) <
                                .5 * MediaQuery.of(context).size.height)
                            ? (widget.maxHeightImageSize.height *
                                (MediaQuery.of(context).size.width /
                                    widget.maxHeightImageSize.width))
                            : .5 * MediaQuery.of(context).size.height
                        : .5 * MediaQuery.of(context).size.height,
                    indicatorColor: Colors.white,
                    indicatorRadius: 0,
                    onPageChanged: (value) => updateImageNumber(value),
                    children: widget.links.map((String link) {
                      CachedNetworkImage image = CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: link,
                        placeholder: (context, url) => const LoadingReddit(),
                      );
                      return image;
                    }).toList(),
                  ),
                  AnimatedOpacity(
                    opacity: imageCounterVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 8),
                      child: DotsIndicator(
                        decorator: const DotsDecorator(
                            size: Size.square(8),
                            activeSize: Size.square(8),
                            activeColor: Colors.white,
                            color: Colors.transparent,
                            shape: CircleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                            spacing: EdgeInsets.all(4.0)),
                        dotsCount:
                            widget.links.isEmpty ? 1 : widget.links.length,
                        position: imageNumber.toDouble(),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: imageCounterVisible ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: 8, end: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 5, bottom: 5),
                      color: Colors.black.withOpacity(0.6),
                      child: Text(
                        '${(imageNumber + 1).toString()}/${widget.links.length}',
                        style: const TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
