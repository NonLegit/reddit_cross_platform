import 'package:flutter/material.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';

class Post extends StatelessWidget {
  final Map data;
  const Post({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PostHeader(
            inHome: false,
            inProfile: false,
            userName: 'Amr',
            communityName: 'vexmains',
            createDate: '2017-07-21T17:32:28Z'),
        const PostBody(title: 'How to lane', type: 'link'),
        PostFooter(),
      ],
    );
  }
}
