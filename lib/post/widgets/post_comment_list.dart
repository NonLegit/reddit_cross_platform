import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import './post.dart';

/// A margin to the left of the posts and comments

class PostCommentList extends StatefulWidget {
  /// The user name

  final String userName;

  /// A widget to be displayed above the posts

  final Widget topOfTheList;

  /// A function which is invoked when the CustomScrollView reaches the end

  final Function updateData;

  /// The list of posts and comments' data to be displayed

  final List<Map<String, dynamic>> data;

  /// A margin to the left of the posts

  final double leftMargin;

  /// A margin to the right of the posts

  final double rightMargin;

  final String type;
  const PostCommentList({
    super.key,
    required this.userName,
    this.topOfTheList = const SizedBox(),
    required this.updateData,
    required this.data,
    this.type = 'home',
    this.leftMargin = 0,
    this.rightMargin = 0,
  });

  @override
  State<PostCommentList> createState() => _PostCommentListState();
}

class _PostCommentListState extends State<PostCommentList> {
  String dateOfcomment(String date) {
    final data1 = DateTime.parse(date);
    final date2 = DateTime.now();
    final difference = date2.difference(data1);
    final differenceMonth = date2.month - data1.month;
    final differenceYear = date2.year - data1.year;

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      final numOfWeeks = difference.inDays ~/ 7;
      if (numOfWeeks > 0) {
        return '${numOfWeeks}w';
      } else {
        return '${difference.inDays}d';
      }
    } else if (differenceYear > 0) {
      return '${differenceYear}y';
    } else {
      return '${differenceMonth}mon';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InViewNotifierCustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        onListEndReached: () => widget.updateData(),
        scrollDirection: Axis.vertical,
        initialInViewIds: const ['0'],
        isInViewPortCondition:
            (double deltaTop, double deltaBottom, double viewPortDimension) {
          return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
        },
        slivers: <Widget>[
          //   Container(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => widget.topOfTheList,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: widget.data.length,
                (context, index) {
              return Container(
                margin: EdgeInsetsDirectional.only(
                    start: widget.leftMargin, end: widget.rightMargin),
                child: InViewNotifierWidget(
                    id: '$index',
                    builder: (context, isInView, child) {
                      if (widget.data[index]['type'] == 'comment') {
                        return Container(
                          color: Colors.white,
                          margin: const EdgeInsetsDirectional.only(
                              top: 10, bottom: 10),
                          child: ListTile(
                            title: Text(
                                widget.data[index]['data'].title.toString()),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              '${(widget.data[index]['data'].ownerType == 'User') ? 'u/' : 'r/'}${widget.data[index]['data'].owner}.${dateOfcomment(widget.data[index]['data'].createdAt.toString())} .${widget.data[index]['data'].votes}'),
                                      const WidgetSpan(
                                          child: Icon(
                                        Typicons.up,
                                        size: 15,
                                      )),
                                    ],
                                  ),
                                ),
                                Text(
                                    widget.data[index]['data'].text.toString()),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (widget.type == 'profile') {
                          return Post.profile(
                            userName: widget.userName,
                            inView: isInView,
                            data: widget.data[index]['data'],
                          );
                        } else if (widget.type == 'community') {
                          return Post.community(
                            userName: widget.userName,
                            inView: isInView,
                            data: widget.data[index]['data'],
                          );
                        } else {
                          return Post.home(
                            userName: widget.userName,
                            inView: isInView,
                            data: widget.data[index]['data'],
                          );
                        }
                      }
                    }),
              );
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.data != null) {
      for (var d in widget.data) {
        d['type'] == 'comment';
        if (d['data'].kind == 'video') {
          d['data'].videoController?.dispose();
        }
      }
    }
    super.dispose();
  }
}
