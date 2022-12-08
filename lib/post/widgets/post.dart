import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_mod_tools.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';
import '../provider/post_provider.dart';

/// This is the main post Widget.
///
/// It takes a map of the post data.
class Post extends StatefulWidget {
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
  State<Post> createState() => _PostState(data);
}

class _PostState extends State<Post> {
  PostModel data;
  bool isApprove = false;
  _PostState(this.data);
  spoiler() {
    setState(() {
      data.spoiler = !(data.spoiler as bool);
    });
  }

  nsfw() {
    setState(() {
      data.nsfw = !(data.nsfw as bool);
    });
  }

  approve() {
    setState(() {
      isApprove = !(isApprove);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PostHeader(
            inHome: widget._inHome,
            inProfile: widget._inProfile,
            authorName: widget.data.author?.name as String,
            ownerName: widget.data.owner?.name as String,
            createDate: widget.data.createdAt as String,
            ownerIcon: widget.data.owner?.icon as String,
            isSaved: widget.data.isSaved as bool,
          ),
          PostBody(
            title: widget.data.title as String,
            type: widget.data.kind as String,
            images: widget.data.images!.cast<String>(),
            text: widget.data.text as String,
            nsfw: widget.data.nsfw as bool,
            spoiler: widget.data.spoiler as bool,
            url: widget.data.url as String,
            flair: widget.data.flairId,
          ),
          PostFooter(
              votes: widget.data.votes as int,
              comments: widget.data.commentCount as int,
              id: widget.data.sId as String,
              postVoteStatus: int.parse(widget.data.postVoteStatus as String)),
          PostModTools(
            isApproved: isApprove,
            isNSFW: data.nsfw as bool,
            isSpoiler: data.spoiler as bool,
            approve: approve,
            nsfw: nsfw,
            spoiler: spoiler,
          ),
        ],
      ),
    );
  }
}
