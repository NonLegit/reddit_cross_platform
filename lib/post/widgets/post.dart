import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_mod_tools.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/post_model.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';
import 'post_card.dart';
import 'post_images.dart';

/// This is the main post Widget.
///
/// It takes a map of the post data.
class Post extends StatefulWidget {
  final PostModel data;
  bool _inHome = false, _inProfile = false;
  final Function updateDate;
  final bool inView;

  /// This is the constructor for home page.
  Post.home(
      {super.key,
      required this.data,
      required this.updateDate,
      required this.inView}) {
    _inHome = true;
  }

  /// This is the constructor for community page.
  Post.community(
      {super.key,
      required this.data,
      required this.updateDate,
      required this.inView});

  /// This is the constructor for profile page.
  Post.profile(
      {super.key,
      required this.data,
      required this.updateDate,
      required this.inView}) {
    _inProfile = true;
  }

  @override
  State<Post> createState() => _PostState(data, updateDate);
}

class _PostState extends State<Post> {
  PostModel data;
  Function updateData;
  bool isApprove = false;
  _PostState(this.data, this.updateData);
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

  updateImageNumber(int number) {
    data.imageNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    updateData(data.sId, data);
    // return PostImages(
    //   links: data.images!.cast<String>(),
    //   maxHeightImageSize: data.maxHeightImageSize as Size,
    //   updateImageNumber: updateImageNumber,
    //   imageNumber: data.imageNumber,
    // );
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
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
            inView: widget.inView,
            data: data,
            updateImageNumber: updateImageNumber,
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
