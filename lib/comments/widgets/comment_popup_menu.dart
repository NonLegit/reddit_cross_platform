import 'package:flutter/material.dart';

class CommentPopUpMenu extends StatelessWidget {
  final bool isSaved;
  const CommentPopUpMenu({super.key, required this.isSaved});
  save() async {
    // if (await Provider.of<PostProvider>(context, listen: false)
    //     .savePost(widget.data.sId as String)) {
    //   widget.data.isSaved = true;
    //   isSaved = true;
    // }
  }

  unSave() async {
    // if (await Provider.of<PostProvider>(context, listen: false)
    //     .unSavePost(widget.data.sId as String)) {
    //   widget.data.isSaved = false;
    //   isSaved = false;
    //   widget.update();
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: 5),
      child: PopupMenuButton(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
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
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: const Icon(Icons.share_outlined),
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
          ),
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: const Icon(Icons.delete_outline_rounded),
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
          ),
        ],
        onSelected: ((value) {
          if (value == 1) {
            isSaved ? unSave() : save();
          }
        }),
        child: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
