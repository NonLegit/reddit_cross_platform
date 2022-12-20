//import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:html/parser.dart';
import 'package:post/comments/models/comment_model.dart';
import 'package:post/comments/providers/comments_provider.dart';
import 'package:post/post/widgets/post_list.dart';
import 'package:post/post/widgets/post_video_in_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../comments/widgets/comment.dart';
import '../../comments/widgets/view_comment.dart';
import '../../providers/Profile_provider.dart';
import '../../widgets/post_sort_bottom.dart';
import '../models/post_model.dart';
import '../widgets/post_video_in_discover.dart';
import '../widgets/post_body.dart';
import '../widgets/post.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';

  const PostScreen({
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  //PostModel data;
  late VideoPlayerController controller;
  late VideoPlayerController controller1;
  bool _isInit = true;
  bool _isLoading = false;
  List<CommentModel>? commentsData = [];

  @override
  void didChangeDependencies() {
    Provider test;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PostCommentsProvider>(context, listen: false)
          .fetchPostComments('s', 1, 2)
          .then((value) {
        commentsData = Provider.of<PostCommentsProvider>(context, listen: false)
            .gettingPostComments;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  updateData() {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    //postsData?.add(postsData![0]);
    setState(() {});
  }

  // final sampleTree = TreeNode.root()
  //   ..addAll([
  //     TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
  //     TreeNode(key: "0C")
  //       ..addAll([
  //         TreeNode(key: "0C1A"),
  //         TreeNode(key: "0C1B"),
  //         TreeNode(key: "0C1C")
  //           ..addAll([
  //             TreeNode(key: "0C1C2A")
  //               ..addAll([
  //                 TreeNode(key: "0C1C2A3A"),
  //                 TreeNode(key: "0C1C2A3B"),
  //                 TreeNode(key: "0C1C2A3C"),
  //               ]),
  //           ]),
  //       ]),
  //     TreeNode(key: "0D"),
  //     TreeNode(key: "0E"),
  //   ]);

  // final sampleTree1 = TreeNode.root()
  //   ..addAll([
  //     TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
  //     TreeNode(key: "0C")
  //       ..addAll([
  //         TreeNode(key: "0C1A"),
  //         TreeNode(key: "0C1B"),
  //         TreeNode(key: "0C1C")
  //           ..addAll([
  //             TreeNode(key: "0C1C2A")
  //               ..addAll([
  //                 TreeNode(key: "0C1C2A3A"),
  //                 TreeNode(key: "0C1C2A3B"),
  //                 TreeNode(key: "0C1C2A3C"),
  //               ]),
  //           ]),
  //       ]),
  //     TreeNode(key: "0D"),
  //     TreeNode(key: "0E"),
  //   ]);
  // updateData(){
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Post.home(
              //   data: widget.data,
              //   inView: false,
              //   userName: 'Amr',
              // )
              Comment(
                data: commentsData![0],
                userName: 'Amr',
              ),
              // Comment(
              //   data: commentsData![2],
              //   userName: 'Amr',
              // ),
              // Comment(
              //   data: commentsData![2],
              //   userName: 'Amr',
              // ),
              // Comment(
              //   data: commentsData![2],
              //   userName: 'Amr',
              // ),
              //     Container(
              //       height: 100,
              //       child: Text('yy'),
              //     ),
              //     Flexible(
              //       child: Container(
              //         height: double.infinity,
              //         color: Colors.blueGrey,
              //         child: TreeView.simple(
              //             indentPadding: 0,
              //             key: UniqueKey(),
              //             tree: sampleTree,
              //             builder: (context, level, item) =>
              //                 ViewComment(level: level)),
              //       ),
              //     ),
              //     Flexible(
              //       child: Container(
              //         height: double.infinity,
              //         color: Colors.amber,
              //         child: TreeView.simple(
              //             indentPadding: 0,
              //             key: UniqueKey(),
              //             tree: sampleTree1,
              //             builder: (context, level, item) =>
              //                 ViewComment(level: level)),
              //       ),
              //     ),
              // Container(
              //   width: 200,
              //   child: PostVideoInDiscover(
              //     videoController: controller,
              //     inView: true,
              //   ),
              // ),
              // Container(
              //   width: 200,
              //   child: PostVideoInDiscover(
              //     videoController: controller1,
              //     inView: true,
              //   ),
              // )
              // _isLoading
              //     ? SizedBox()
              //     : PostList(
              //         data: postsData as List<PostModel>,
              //         updateData: updateData,
              //         userName: 'Amr',
              //         topOfTheList: PostSortBottom(
              //           page: 1,
              //           routeNamePop: 's',
              //           type: 'New',
              //           userName: 'Amr',
              //           //_dropDownValue, _icon
              //         ),
              //       ),
            ],
          ),
        ));
  }
}
