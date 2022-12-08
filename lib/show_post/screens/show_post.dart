import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../notification/widgets/list_tile_widget.dart';
import '../widgets/edit_post.dart';

class ShowPostDetails extends StatefulWidget {
  static const routeName = '/showpost-screen';
  const ShowPostDetails({super.key});

  @override
  State<ShowPostDetails> createState() => _ShowPostDetailsState();
}

class _ShowPostDetailsState extends State<ShowPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          // IconButton(
          //   onPressed: () {
          PopupMenuButton(
            // elevation: -1,
            // position: PopupMenuPosition.under,
            constraints: BoxConstraints.expand(width: 60.w, height: 55.h),
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) {
              //return list.map((e) {
              return [
                PopupMenuItem(
                    child: ListTileWidget(icon: Icons.share, title: 'Share')),
                PopupMenuItem(
                    child: ListTileWidget(icon: Icons.save, title: 'Save')),
                PopupMenuItem(
                    child:
                        ListTileWidget(icon: Icons.copy, title: 'Copy text')),
                PopupMenuItem(
                    child: ListTileWidget(
                        icon: Icons.edit,
                        title: 'Edit',
                        onpressed: () => Navigator.of(context)
                            .popAndPushNamed(EditPost.routeName))),
                PopupMenuItem(
                    child: ListTileWidget(
                        icon: Icons.tag, title: 'Add post flair')),
                PopupMenuItem(
                    child: ListTileWidget(
                        icon: Icons.warning, title: 'Mark spoiler')),
                PopupMenuItem(
                    child: ListTileWidget(
                        icon: Icons.plus_one, title: 'Mark NSFW')),
                PopupMenuItem(
                    child: ListTileWidget(icon: Icons.delete, title: 'Delete')),
              ];
            },
          ),
        ],
      ),
    );
  }
}
