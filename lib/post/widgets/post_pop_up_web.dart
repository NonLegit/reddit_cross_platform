import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../comments/widgets/comments_list.dart';
import '../../post/models/post_model.dart';
import 'post.dart';

//import '../widgets/edit_post.dart';

class PostPopUpWeb extends StatefulWidget {
  final String userName;
  final PostModel data;
  static const routeName = '/showpost-screen';

  const PostPopUpWeb({
    super.key,
    required this.userName,
    required this.data,
  });

  @override
  State<PostPopUpWeb> createState() => _PostPopUpWebState();
}

class _PostPopUpWebState extends State<PostPopUpWeb> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.width * .8,
        width: MediaQuery.of(context).size.width * .8,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 40.w,
            child: Column(
              children: [
                Post.home(
                    data: widget.data,
                    userName: widget.userName,
                    inView: true,
                    inScreen: true),
                CommentsList(
                  postId: widget.data.sId ?? '',
                  userName: widget.userName,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
