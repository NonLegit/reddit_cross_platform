import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/mod_subreddit_post_sort_bottom.dart';
import '../../post/widgets/post.dart';
import '../../post/test_data.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import '../../post/models/post_model.dart';
import '../../providers/subreddit_post.dart';

class ModeratedSubriddetPosts extends StatefulWidget {
  final String routeNamePop;
  final String subredditName;

  ModeratedSubriddetPosts(
      {Key? key, required this.routeNamePop, required this.subredditName})
      : super(key: key);
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
  @override
  State<ModeratedSubriddetPosts> createState() => _ModeratedSubriddetPosts();
}

class _ModeratedSubriddetPosts extends State<ModeratedSubriddetPosts> {
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? posts = [];
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<SubredditPostProvider>(context, listen: false)
          .fetchNewProfilePosts(widget.subredditName)
          .then((value) {
        posts = Provider.of<SubredditPostProvider>(context, listen: false)
            .gettingProfilePostData;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        ModSubredditPostSortBottom(
          widget.routeNamePop,
          //_dropDownValue, _icon
        ),
        //Select the type of Posts
        SingleChildScrollView(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: ((context, index) => Post.community(
                  data: posts![index],
                )),
            itemCount: posts!.length,
          ),
        ),
      ],
    );
  }
}
