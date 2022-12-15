import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_post.dart';
import '../../widgets/loading_reddit.dart';
import '../models/post_model.dart';
import './post.dart';

class PostList extends StatefulWidget {
  final String userName;
  const PostList({super.key, required this.userName});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? postsData = [];
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfilePostProvider>(context, listen: false)
          .fetchProfilePosts(widget.userName)
          .then((value) {
        print('hi');
        postsData = Provider.of<ProfilePostProvider>(context, listen: false)
            .gettingProfilePostData;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  updateData(String id, PostModel newData) {
    for (PostModel data in postsData!) {
      if (data.sId == id) {
        data = newData;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? Flexible(
            child: InViewNotifierList(
              scrollDirection: Axis.vertical,
              initialInViewIds: ['0'],
              itemCount: postsData?.length,
              isInViewPortCondition: (double deltaTop, double deltaBottom,
                  double viewPortDimension) {
                return deltaTop < (0.5 * viewPortDimension) &&
                    deltaBottom > (0.5 * viewPortDimension);
              },
              builder: (
                BuildContext context,
                int index,
              ) {
                print('hi');

                return InViewNotifierWidget(
                  id: '$index',
                  builder: (context, isInView, child) => Post.profile(
                    key: UniqueKey(),
                    inView: isInView,
                    data: postsData![index],
                    updateDate: updateData,
                  ),
                );
              },
              // child: ListView.builder(
              //   physics: const ClampingScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: ((context, index) => Post.profile(
              //         key: UniqueKey(),
              //         data: posts![index],
              //       )),
            ),
          )
        : LoadingReddit();
  }

  @override
  void dispose() {
    if (postsData != null) {
      for (var post in postsData!) {
        if (post.kind == 'video') {
          post.videoController?.dispose();
        }
      }
    }
    super.dispose();
  }
}
