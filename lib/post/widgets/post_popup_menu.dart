import 'package:flutter/material.dart';

class PostPopupMenu extends StatefulWidget {
  final bool isSaved;
  const PostPopupMenu({super.key, required this.isSaved});

  @override
  State<PostPopupMenu> createState() => _PostPopupMenuState(isSaved);
}

class _PostPopupMenuState extends State<PostPopupMenu> {
  bool isSaved;

  _PostPopupMenuState(this.isSaved);

  save() {
    setState(() {
      isSaved = true;
    });
  }

  unSave() {
    setState(() {
      isSaved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: 5),
      child: PopupMenuButton(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.secondary,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 5),
                  child: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                ),
                Text(
                  isSaved ? 'Unsave' : 'Save',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            value: 1,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 5),
                  child: Icon(Icons.share_outlined),
                ),
                Text(
                  'Share',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            value: 2,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 5),
                  child: Icon(Icons.delete_outline_rounded),
                ),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            value: 3,
          ),
        ],
        onSelected: ((value) {
          if (value == 1) {
            isSaved ? unSave() : save();
          }
        }),
      ),
    );
  }
}
