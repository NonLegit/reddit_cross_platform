import 'package:flutter/material.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';

/// This is the main post Widget.
///
/// It takes a map of the post data.
class Post extends StatelessWidget {
  final Map<String, Object> data;
  bool _inHome = false, _inProfile = false;

  /// This is the constructor for home page.
  Post.home({super.key, required this.data}) {
    _inHome = true;
  }

  /// This is the constructor for community page.
  Post.community({super.key, required this.data});

  /// This is the constructor for profile page.
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
            userName: data['userName'].toString(),
            communityName: data['communityName'].toString(),
            createDate: data['createDate'].toString()),
        PostBody(
            title: data['title'].toString(),
            type: data['type'].toString(),
            images: data['images'] as List<String>,
            text: data['text'].toString(),
            nsfw: data['nsfw'] as bool,
            spoiler: data['spoiler'] as bool,
            url: data['url'].toString()),
        PostFooter(
            votes: data['votes'] as int, comments: data['comments'] as int),
      ],
    );
  }
}
