import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';

import '../helpers/fetch_preview.dart';

class PostBody extends StatefulWidget {
  final String title;
  final String type;
  final String url;
  final bool nsfw;
  final bool spoiler;

  const PostBody(
      {super.key,
      required this.title,
      required this.type,
      this.nsfw = false,
      this.spoiler = false,
      this.url = 'https://www.facebook.com/'});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == 'link') {
      String? link, linkImage;
      FetchPreview().fetch(widget.url).then((res) {
        setState(
          () {
            link = res['link'];
            linkImage = res['image'];
          },
        );
      });
    }

    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: [
              if (widget.nsfw)
                Container(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
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
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Text(
                        'NSFW',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              if (widget.spoiler)
                Container(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    children: [
                      Icon(
                        MfgLabs.attention,
                        size: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        'Spoiler',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
                // if (((widget.spoiler || widget.nsfw) &&
                //         !(widget.type == 'text' || widget.type == 'poll')) ||
                //     widget.type == 'link')
                  
              ],
            ),
          )
        ],
      ),
    );
  }
}
