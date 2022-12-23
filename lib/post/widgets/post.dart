import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_body_in_screen.dart';
import 'package:post/post/widgets/post_mod_tools.dart';
import 'package:provider/provider.dart';
import '../../moderation_settings/models/moderators.dart';
import '../../moderation_settings/models/user.dart';
import '../../moderation_settings/provider/moderation_settings_provider.dart';
import '../models/post_model.dart';
import './post_header.dart';
import './post_footer.dart';
import './post_body.dart';

/// This is the main post Widget.
///
class Post extends StatefulWidget {
  /// The data of the post
  final PostModel data;
  bool _inHome = false, _inProfile = false;
  //final Function updateDate;
  /// A boolean to check if in view
  final bool inView;

  /// The user name
  final String userName;

  /// a boolean to determine if in the post screen
  final bool inScreen;

  /// This is the constructor for home page.
  Post.home({
    super.key,
    required this.data,
    required this.inView,
    required this.userName,
    this.inScreen = false,
  }) {
    _inHome = true;
  }

  /// This is the constructor for community page.
  Post.community({
    super.key,
    required this.data,
    required this.inView,
    this.inScreen = false,
    required this.userName,
  });

  /// This is the constructor for profile page.
  Post.profile({
    super.key,
    required this.data,
    required this.inView,
    this.inScreen = false,
    required this.userName,
  }) {
    _inProfile = true;
  }

  @override
  State<Post> createState() => _PostState(data);
}

class _PostState extends State<Post> {
  PostModel data;
  //Function updateData;
  bool isApprove = false;
  _PostState(
    this.data,
  );

  update() {
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    if (widget.data.isModerator == null &&
        widget.data.ownerType == 'Subreddit') {
      final provider =
          Provider.of<ModerationSettingProvider>(context, listen: false);
      await provider
          .getUser(
              widget.data.owner?.name as String, UserCase.moderator, context)
          .then((value) async {
        List<Moderators>? moderators = provider.moderators;

        for (var mod in moderators!) {
          widget.data.isModerator = false;
          if (mod.userName == widget.userName) {
            widget.data.isModerator = true;
            break;
          }
        }
        setState(() {});
      });
    }
    super.didChangeDependencies();
  }

  updateImageNumber(int number) {
    data.imageNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    // return PostImages(
    //   links: data.images!.cast<String>(),
    //   maxHeightImageSize: data.maxHeightImageSize as Size,
    //   updateImageNumber: updateImageNumber,
    //   imageNumber: data.imageNumber,
    // );
    return widget.data.isDeleted ?? false
        ? const SizedBox()
        : Container(
            margin: const EdgeInsetsDirectional.only(bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PostHeader(
                  inScreen: widget.inScreen,
                  update: update,
                  isMyPost: (widget.data.author?.name == widget.userName),
                  inHome: widget._inHome,
                  inProfile: widget._inProfile,
                  authorName: widget.data.author?.name as String,
                  ownerName: widget.data.owner?.name as String,
                  createDate: widget.data.createdAt as String,
                  ownerIcon: widget.data.owner?.icon as String,
                  isSaved: widget.data.isSaved as bool,
                  data: widget.data,
                ),
                widget.inScreen
                    ? PostBodyInScreen(
                        data: data, inView: true, userName: widget.userName)
                    : PostBody(
                        userName: widget.userName,
                        inView: widget.inView,
                        data: data,
                      ),
                PostFooter(
                    userName: widget.userName,
                    inScreen: widget.inScreen,
                    data: widget.data,
                    isMyPost: (widget.data.author?.name == widget.userName),
                    votes: widget.data.votes as int,
                    comments: widget.data.commentCount as int,
                    id: widget.data.sId as String,
                    postVoteStatus:
                        int.parse(widget.data.postVoteStatus as String)),
                (widget.data.isModerator ?? false)
                    ? PostModTools(
                        inScreen: widget.inScreen,
                        isRemoved: widget.data.removed as bool,
                        isCommentsLocked: widget.data.locked as bool,
                        isMyPost: (widget.data.author?.name == widget.userName),
                        data: data,
                        isApproved: data.approved as bool,
                        isNSFW: data.nsfw as bool,
                        isSpoiler: data.spoiler as bool,
                        update: update)
                    : const SizedBox(),
              ],
            ),
          );
  }
}
