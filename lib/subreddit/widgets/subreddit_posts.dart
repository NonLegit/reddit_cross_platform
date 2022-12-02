import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/post_sort_bottom.dart';
import '../../post/widgets/post.dart';
import '../../post/test_data.dart';

class SubredditPosts extends StatefulWidget {
  final String routeNamePop;
  SubredditPosts({
    Key? key,
    required this.routeNamePop,
  }) : super(key: key);
  final List posts = TestData.testData;
  // [
  //   {'username': 'ahmed', 'title': 'hello world1'},
  //   {'username': 'sayed', 'title': 'hello world2'},
  //   {'username': 'sayed', 'title': 'hello world3'},
  //   {'username': 'ahmed', 'title': 'hello world1'},
  //   {'username': 'sayed', 'title': 'hello world2'},
  //   {'username': 'sayed', 'title': 'hello world3'},
  //   {'username': 'ahmed', 'title': 'hello world1'},
  //   {'username': 'sayed', 'title': 'hello world2'},
  //   {'username': 'sayed', 'title': 'hello world3'}
  // ];
  // Posts(this.routeNamePop);
  @override
  State<SubredditPosts> createState() => _SubredditPosts();
}

class _SubredditPosts extends State<SubredditPosts> {
//     final  String routeNamePop;
//  _PostsState(this.routeNamePop);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        PostSortBottom(
          widget.routeNamePop,
          //_dropDownValue, _icon
        ),
        //Select the type of Posts
        SingleChildScrollView(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: ((context, index) => Post.community(
                  data: widget.posts[index],
                )),
            itemCount: widget.posts.length,
          ),
        ),
      ],
    );
  }
}
