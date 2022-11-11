import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Typicons.up_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text('Vote',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Typicons.down_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          TextButton.icon(
            // ignore: avoid_print
            onPressed: () => print('hi'),
            icon: Icon(
              FontAwesome.comment_empty,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: Text(
              'Comment',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: Text('Share',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }
}
