import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';
import '../post/widgets/post.dart';

class ProfilePosts extends StatefulWidget {
  final String routeNamePop;
  ProfilePosts({
    Key? key,
    required this.routeNamePop,
  }) : super(key: key);
  final List posts = [
    {'username': 'ahmed', 'title': 'hello world1'},
    {'username': 'sayed', 'title': 'hello world2'},
    {'username': 'sayed', 'title': 'hello world3'},
    {'username': 'ahmed', 'title': 'hello world1'},
    {'username': 'sayed', 'title': 'hello world2'},
    {'username': 'sayed', 'title': 'hello world3'},
    {'username': 'ahmed', 'title': 'hello world1'},
    {'username': 'sayed', 'title': 'hello world2'},
    {'username': 'sayed', 'title': 'hello world3'}
  ];
  // Posts(this.routeNamePop);
  @override
  State<ProfilePosts> createState() => _ProfilePosts();
}

class _ProfilePosts extends State<ProfilePosts> {
//     final  String routeNamePop;
//  _PostsState(this.routeNamePop);
  final _dropDownValue = 'HOT POST';
  final _icon = Icons.local_fire_department_rounded;
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        PostSortBottom(widget.routeNamePop, _dropDownValue, _icon),
        SingleChildScrollView(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: ((context, index) => Post.profile(
                  data: widget.posts[index],
                )),
            itemCount: widget.posts.length,
          ),
        ),

        // widget.posts.forEach((post) {
        //   Post.community(
        //     data: post,
        //   );
        // }),
      ],
    );
  }
  //     Post.community(data: {'username': 'ahmed'})),
  // itemCount: 10,

}
