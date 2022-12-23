import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/comments/screens/add_comment_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../comments/widgets/comments_list.dart';
import '../../notification/widgets/list_tile_widget.dart';
import '../../post/models/post_model.dart';
import '../../post/widgets/post.dart';
import '../widgets/edit_post.dart';

class ShowPostDetailsWeb extends StatefulWidget {
  static const routeName = '/showpost-screen';

  const ShowPostDetailsWeb({
    super.key,
  });

  @override
  State<ShowPostDetailsWeb> createState() => _ShowPostDetailsWebState();
}

class _ShowPostDetailsWebState extends State<ShowPostDetailsWeb> {
  late String userName;
  late PostModel data;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================Fetch subreddit data =======================================//

    var temp =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    userName = temp['userName'];
    data = temp['data'];
    super.didChangeDependencies();
  }

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
      body: Center(
        child: Container(
          width: 50.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Post.home(
                    data: data,
                    userName: userName,
                    inView: true,
                    inScreen: true),
                CommentsList(
                  postId: data.sId ?? '',
                  userName: userName,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsetsDirectional.all(5),
          child: GestureDetector(
            onTap: () {
              Get.to(AddCommentScreen(),
                  arguments: {'parentId': data.sId, 'title': data.title});
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const Padding(
                padding: EdgeInsetsDirectional.all(5),
                child: Text(
                  'Add a comment',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          )

          //  TextFormField(
          //   onChanged: (value) {},
          //   onTap: () {
          //     Get.to(AddCommentScreen(),
          //         arguments: {'parentId': data.sId, 'title': data.title});
          //   },
          //   enabled: false,
          //   style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          //   showCursor: true,

          //   textAlign: TextAlign.start,
          //   decoration: InputDecoration(
          //     hintText: 'Add a comment',
          //     enabledBorder: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(width: 2, color: Colors.grey), //<-- SEE HERE
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
