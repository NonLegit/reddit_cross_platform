import 'package:flutter/material.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../post/models/post_model.dart';
import '../../providers/subreddit_post.dart';
import '../../widgets/post_sort_bottom.dart';
import '../../post/widgets/post.dart';
import '../../post/test_data.dart';

class SubredditPosts extends StatefulWidget {
  final String routeNamePop;
  final String subredditName;
  SubredditPosts({
    Key? key,
    required this.routeNamePop,
    required this.subredditName,
  }) : super(key: key);
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
    return _isLoading
        ? LoadingReddit()
        : ListView(
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
                    inView: false,
                        data: posts![index],
                        updateDate: print,
                      )),
                  itemCount: posts?.length,
                ),
              ),
            ],
          );
  }
}
