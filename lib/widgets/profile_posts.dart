import 'package:flutter/material.dart';
import 'package:post/widgets/loading_reddit.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';
import '../post/widgets/post.dart';
import '../post/test_data.dart';
import 'package:provider/provider.dart';
import '../providers/profile_post.dart';
import '../post/models/post_model.dart';

class ProfilePosts extends StatefulWidget {
  final String routeNamePop;
  final String userName;
  ProfilePosts({
    Key? key,
    required this.routeNamePop,
    required this.userName,
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
  State<ProfilePosts> createState() => _ProfilePosts();
}

class _ProfilePosts extends State<ProfilePosts> {
//     final  String routeNamePop;
//  _PostsState(this.routeNamePop);
  final _dropDownValue = 'HOT POST';
  final _icon = Icons.local_fire_department_rounded;
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? posts = [];
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfilePostProvider>(context, listen: false)
          .fetchProfilePosts(widget.userName)
          .then((value) {
        posts = Provider.of<ProfilePostProvider>(context, listen: false)
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
    return (!_isLoading)
        ? ListView(
            scrollDirection: Axis.vertical,
            children: [
              PostSortBottom(
                widget.routeNamePop,
                //_dropDownValue, _icon
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) => Post.profile(
                        data: posts![index],
                      )),
                  itemCount: posts?.length,
                ),
              ),

              // widget.posts.forEach((post) {
              //   Post.community(
              //     data: post,
              //   );
              // }),
            ],
          )
        : LoadingReddit();
  }
  //     Post.community(data: {'username': 'ahmed'})),
  // itemCount: 10,

}
