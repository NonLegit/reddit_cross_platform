import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_header.dart';
import 'package:post/post/widgets/post_list.dart';
import 'package:post/widgets/loading_reddit.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';
import '../post/widgets/post.dart';
import 'package:provider/provider.dart';
import '../providers/profile_post_provider.dart';
import '../post/models/post_model.dart';

class ProfilePosts extends StatefulWidget {
  final String routeNamePop;
  final String userName;
//late ScrollController controller;
  ProfilePosts({
    Key? key,
    required this.routeNamePop,
    required this.userName,
    //required this.controller,
  }) : super(key: key);
  @override
  State<ProfilePosts> createState() => _ProfilePosts();
}

class _ProfilePosts extends State<ProfilePosts> {
//     final  String routeNamePop;
//  _PostsState(this.routeNamePop);
  final _dropDownValue = 'HOT POST';
  final _icon = Icons.local_fire_department_rounded;
  // bool _isInit = true;
  // bool _isLoading = false;
  // List<PostModel>? posts = [];
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<ProfilePostProvider>(context, listen: false)
  //         .fetchProfilePosts(widget.userName)
  //         .then((value) {
  //       posts = Provider.of<ProfilePostProvider>(context, listen: false)
  //           .gettingProfilePostData;
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  final sampleTree = TreeNode.root()
    ..addAll([
      TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
      TreeNode(key: "0C")
        ..addAll([
          TreeNode(key: "0C1A"),
          TreeNode(key: "0C1B"),
          TreeNode(key: "0C1C")
            ..addAll([
              TreeNode(key: "0C1C2A")
                ..addAll([
                  TreeNode(key: "0C1C2A3A"),
                  TreeNode(key: "0C1C2A3B"),
                  TreeNode(key: "0C1C2A3C"),
                ]),
            ]),
        ]),
      TreeNode(key: "0D"),
      TreeNode(key: "0E"),
    ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      // scrollDirection: Axis.vertical,
      children: [
        // PostSortBottom(
        //   widget.routeNamePop,
        //   //_dropDownValue, _icon
        // ),
        // Container(
        //   height: 500,
        //   child: TreeView.simple(
        //     key: UniqueKey(),
        //     tree: sampleTree,
        //     builder: (context, level, item) => PostHeader(
        //       authorName: 'Amr',
        //       createDate: '2022-12-06T14:21:02.113Z',
        //       isSaved: false,
        //       ownerIcon: '',
        //       ownerName: 'test',
        //       inProfile: false,
        //       inHome: false,
        //     ),
        //   ),
        // ),

        PostList(userName: widget.userName),
        // SingleChildScrollView(
        //   child: ListView.builder(
        //     physics: const ClampingScrollPhysics(),
        //     shrinkWrap: true,
        //     itemBuilder: ((context, index) => Post.profile(
        //           key: UniqueKey(),
        //           data: posts![index],
        //         )),
        //     itemCount: posts?.length,
        //   ),
        // ),

        // widget.posts.forEach((post) {
        //   Post.community(
        //     data: post,
        //   );
        // }),
      ],
    );
    // : LoadingReddit();
  }
}
