import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:blur/blur.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:post/post/models/post_model.dart';

import '../network/fetch_preview.dart';
import '../network/open_link.dart';
import '../network/prepare_images.dart';

/// This Widget is responsible for the body of the post.

class PostBody extends StatefulWidget {
  /// title of the post.
  final String title;

  /// the type of the post.
  ///
  /// text, image, or link.
  final String type;

  /// the url to display in the post.
  final String url;

  /// the post is nsfw if true.
  final bool nsfw;

  /// the post is spoiler if true.
  final bool spoiler;

  /// the text of the post.
  final String text;

  /// the array of images to display
  final List<String> images;

  /// the flair data
  final FlairId? flair;

  const PostBody(
      {super.key,
      required this.title,
      required this.type,
      this.nsfw = false,
      this.spoiler = false,
      required this.url,
      this.text = '',
      this.images = const [],
      required this.flair});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  String? link = '', linkImage = '';
  List<Image> imageList = [];
  double maxImageHeight = 0;
  int imageNumber = 0;
  bool imageCounterVisible = false;
  double max = 200;
  void updateImageNumber(value) => setState(() {
        imageNumber = value;
        imageCounterVisible = true;
        Future.delayed(const Duration(milliseconds: 3000), () {
          setState(() {
            imageCounterVisible = false;
          });
        });
      });

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'link' && linkImage == '') {
      FetchPreview().fetch(widget.url).then((res) {
        print(widget.url);
        print(linkImage);
        setState(
          () {
            link = res['link'];
            linkImage = res['image'];
          },
        );
      });
    }

    if (widget.type == 'image' && imageList.isEmpty) {
      PrepareImages.loadImages(widget.images).then((res) {
        setState(() {
          imageList = res;
        });
      });
    }
    if (imageList.isNotEmpty && maxImageHeight != max) {
      PrepareImages.getMaxHeight(imageList).then((res) {
        setState(() {
          maxImageHeight = res;
          max = res;
        });
      });
    }

    return Flexible(
      child: Container(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsetsDirectional.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.nsfw || widget.spoiler)
                    Container(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 10, start: 10),
                      child: Row(
                        children: [
                          if (widget.nsfw)
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
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const Text(
                                  'NSFW',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          if (widget.spoiler)
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: (widget.nsfw) ? 10 : 0),
                              child: Row(
                                children: [
                                  Icon(
                                    MfgLabs.attention,
                                    size: 18,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  Text(
                                    'Spoiler',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  Container(
                    padding:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
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
                        color:
                            HexColor(widget.flair?.backgroundColor as String),
                      ),
                      padding: const EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 5, bottom: 5),
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 10, end: 10),
                      child: Text(
                        widget.flair?.text as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: HexColor(widget.flair?.textColor as String),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  if (widget.type == 'text' &&
                      widget.text.length > 139 &&
                      !widget.spoiler)
                    Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 10),
                      child: Text(
                        widget.text,
                        maxLines: 3,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (widget.type == 'image' &&
                      widget.spoiler == false &&
                      widget.nsfw == false)
                    Flexible(
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, bottom: 10),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ImageSlideshow(
                                  indicatorColor: Colors.white,
                                  indicatorRadius: 0,
                                  height: (maxImageHeight > 1000)
                                      ? 1000
                                      : maxImageHeight,
                                  onPageChanged: updateImageNumber,
                                  children: imageList.isEmpty
                                      ? [
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/community_icon.png'),
                                          ),
                                        ]
                                      : imageList,
                                ),
                                AnimatedOpacity(
                                  opacity: imageCounterVisible ? 1 : 0,
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        bottom: 8),
                                    child: DotsIndicator(
                                      decorator: const DotsDecorator(
                                          size: Size.square(8),
                                          activeSize: Size.square(8),
                                          activeColor: Colors.white,
                                          color: Colors.transparent,
                                          shape: CircleBorder(
                                            side: BorderSide(
                                                width: 1, color: Colors.white),
                                          ),
                                          spacing: EdgeInsets.all(4.0)),
                                      dotsCount: imageList.isEmpty
                                          ? 1
                                          : imageList.length,
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
                                margin: const EdgeInsetsDirectional.only(
                                    top: 8, end: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10, end: 10, top: 5, bottom: 5),
                                    color: Colors.black.withOpacity(0.6),
                                    child: Text(
                                      '${(imageNumber + 1).toString()}/${imageList.length}',
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
                    ),
                ],
              ),
            ),
            if (((widget.spoiler || widget.nsfw) &&
                    !(widget.type == 'text' || widget.type == 'poll')) ||
                widget.type == 'link')
              ((linkImage != null && (linkImage as String).isNotEmpty) ||
                      (widget.images.isNotEmpty &&
                          widget.images[0].isNotEmpty &&
                          widget.type == 'image'))
                  ? GestureDetector(
                      onTap: widget.type == 'link'
                          ? () => OpenLink.openLink(widget.url)
                          : null,
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              (widget.spoiler)
                                  ? Blur(
                                      child: Image.network(
                                        (widget.type == 'link')
                                            ? linkImage as String
                                            : widget.images[0],
                                        height: 70,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.network(
                                      (widget.type == 'link')
                                          ? linkImage as String
                                          : widget.images[0],
                                      height: 70,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                              if (link != null && link != '')
                                Container(
                                  width: 100,
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 5, end: 5, top: 5, bottom: 5),
                                  color: Colors.black.withOpacity(0.6),
                                  child: Text(
                                    link as String,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 100,
                        height: 80,
                        margin:
                            const EdgeInsetsDirectional.only(end: 4, start: 4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
