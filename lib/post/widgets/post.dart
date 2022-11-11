import 'package:flutter/material.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';

class Post extends StatelessWidget {
  final Map data;
  bool _inHome = false, _inProfile = false;
  Post.home({super.key, required this.data}) {
    _inHome = true;
  }
  Post.community({super.key, required this.data});
  Post.profile({super.key, required this.data}) {
    _inProfile = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostHeader(
            inHome: _inHome,
            inProfile: _inProfile,
            userName: 'Amr',
            communityName: 'vexmains',
            createDate: '2017-07-21T17:32:28Z'),
        const PostBody(title: 'How to lane', type: 'link'),
        PostFooter(),
      ],
    );
  }
}
