import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';
import '../provider/post_provider.dart';

/// This is the main post Widget.
///
/// It takes a map of the post data.
class Post extends StatelessWidget {
  final PostModel data;
  bool _inHome = false, _inProfile = false;

  /// This is the constructor for home page.
  Post.home({super.key, required this.data}) {
    _inHome = true;
  }

  /// This is the constructor for community page.
  Post.community({super.key, required this.data}) {}

  /// This is the constructor for profile page.
  Post.profile({super.key, required this.data}) {
    _inProfile = true;
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostHeader(
            inHome: _inHome,
            inProfile: _inProfile,
            userName: data.owner?.name as String,
            communityName: data.owner?.name as String,
            createDate: data.createdAt as String),
        PostBody(
            title: data.title as String,
            type: data.kind as String,
            images: data.images!.cast<String>(),
            text: data.text as String,
            nsfw: data.nsfw as bool,
            spoiler: data.spoiler as bool,
            url: data.url as String),
        PostFooter(
            votes: data.votes as int,
            comments: data.commentCount as int,
            id: data.sId as String,
            postVoteStatus: int.parse(data.postVoteStatus as String)),
      ],
    );
  }
}
