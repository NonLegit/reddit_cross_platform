import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import '../models/post_model.dart';
import './post.dart';

class PostList extends StatefulWidget {
  final String userName;
  final Widget topOfTheList;
  final Function updateData;
  final List<PostModel> data;
  final String type;
  const PostList(
      {super.key,
      required this.userName,
      this.topOfTheList = const SizedBox(),
      required this.updateData,
      required this.data,
      this.type = 'home'});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InViewNotifierCustomScrollView(
        onListEndReached: () => widget.updateData(),
        scrollDirection: Axis.vertical,
        initialInViewIds: const ['0'],
        isInViewPortCondition:
            (double deltaTop, double deltaBottom, double viewPortDimension) {
          return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => widget.topOfTheList,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: widget.data.length,
                (context, index) {
              return InViewNotifierWidget(
                  id: '$index',
                  builder: (context, isInView, child) {
                    if (widget.type == 'profile') {
                      return Post.profile(
                        userName: widget.userName,
                        inView: isInView,
                        data: widget.data[index],
                      );
                    } else if (widget.type == 'community') {
                      return Post.community(
                        userName: widget.userName,
                        inView: isInView,
                        data: widget.data[index],
                      );
                    } else {
                      return Post.home(
                        userName: widget.userName,
                        inView: isInView,
                        data: widget.data[index],
                      );
                    }
                  });
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.data != null) {
      for (var post in widget.data) {
        if (post.kind == 'video') {
          post.videoController?.dispose();
        }
      }
    }
    super.dispose();
  }
}
