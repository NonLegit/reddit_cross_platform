import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:post/post/widgets/post_pop_up_menu.dart';
import 'package:post/post/widgets/user_info_popup.dart';
import 'package:post/subreddit/screens/subreddit_screen.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../models/post_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// This Widget is responsible for the header of the post.

class PostHeader extends StatefulWidget {
  final bool inProfile;
  final bool inHome;

  /// The user name.
  final String authorName;

  /// The owner name.
  final String ownerName;

  /// The create date of the post.
  final String createDate;

  /// The icon of the community
  final String ownerIcon;

  /// Is the post saved;
  final bool isSaved;

  /// Check if it's a post created by the user
  final bool isMyPost;

  final PostModel data;
  final Function update;
  final bool inScreen;
  const PostHeader({
    super.key,
    this.inProfile = false,
    this.inHome = false,
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.isSaved,
    required this.ownerIcon,
    required this.isMyPost,
    required this.data,
    required this.update,
    required this.inScreen,
  });

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: (!widget.inScreen && (widget.data.isSpam ?? false))
          ? Colors.blueGrey[50]
          : Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 15, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.inHome
                ? _PostHeaderHome(
                    ownerType: widget.data.ownerType ?? 'Subreddit',
                    isModerator: widget.data.isModerator ?? false,
                    isMyPost: widget.isMyPost,
                    authorName: widget.authorName,
                    ownerName: widget.ownerName,
                    createDate: widget.createDate,
                    ownerIcon: widget.ownerIcon,
                  )
                : PostHeaderBasic(
                    ownerType: widget.data.ownerType ?? 'Subreddit',
                    isModerator: widget.data.isModerator ?? false,
                    isMyPost: widget.isMyPost,
                    inProfile: widget.inProfile,
                    authorName: widget.authorName,
                    ownerName: widget.ownerName,
                    createDate: widget.createDate,
                    ownerIcon: widget.ownerIcon,
                  ),
            Row(
              children: [
                (widget.data.isSpam ?? false)
                    ? Icon(
                        Icons.block_flipped,
                        color: Colors.red[500],
                        size: 18,
                      )
                    : const SizedBox(),
                (widget.data.locked ?? false)
                    ? Icon(
                        FontAwesome5.lock,
                        color: Colors.amber[600],
                        size: 18,
                      )
                    : const SizedBox(),
                (widget.data.approved ?? false)
                    ? Icon(
                        Icons.done,
                        color: Colors.green[500],
                        size: 18,
                      )
                    : const SizedBox(),
                !widget.inScreen || kIsWeb
                    ? PostPopupMenu(
                        isMyPost: widget.isMyPost,
                        data: widget.data,
                        update: widget.update,
                        isSaved: widget.isSaved,
                      )
                    : const SizedBox(
                        width: 20,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// This is a class for the basic info in the header.
class PostHeaderBasic extends StatefulWidget {
  final bool inProfile;
  final String authorName;
  final String ownerName;
  final String createDate;
  final String ownerIcon;
  final String ownerType;
  final bool isMyPost;
  final bool isModerator;
  const PostHeaderBasic({
    super.key,
    required this.isModerator,
    this.inProfile = false,
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.ownerIcon,
    required this.isMyPost,
    required this.ownerType,
  });

  /// This function is used to get how far time passed from a given date.
  static String calculateHowOld(date) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(date));
    if (difference.inDays >= 365) {
      howOld = '${difference.inDays ~/ 365}y';
    } else if (difference.inDays >= 30) {
      howOld = '${difference.inDays ~/ 30}mo';
    } else if (difference.inDays >= 1) {
      howOld = '${difference.inDays}d';
    } else if (difference.inMinutes >= 60) {
      howOld = '${difference.inHours}h';
    } else if (difference.inSeconds >= 60) {
      howOld = '${difference.inMinutes}m';
    } else {
      howOld = '${difference.inSeconds}s';
    }
    return howOld;
  }

  @override
  State<PostHeaderBasic> createState() => _PostHeaderBasicState();
}

class _PostHeaderBasicState extends State<PostHeaderBasic> {
  @override
  Widget build(BuildContext context) {
    String howOld = PostHeaderBasic.calculateHowOld(widget.createDate);
    return Row(
      children: [
        widget.ownerType == 'User' && !widget.inProfile
            ? const SizedBox()
            : InkWell(
                onTap: (!widget.inProfile)
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => UserInfoPopUp(
                            authorName: widget.authorName,
                            isMine: widget.isMyPost,
                          ),
                        );
                      }
                    : () {
                        Navigator.of(context).pushNamed(
                            widget.isModerator
                                ? ModeratedSubredditScreen.routeName
                                : SubredditScreen.routeName,
                            arguments: widget.ownerName);
                      },
                child: Row(
                  children: [
                    if (widget.inProfile)
                      Container(
                        width: 15,
                        height: 15,
                        margin: const EdgeInsetsDirectional.only(end: 2),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.ownerIcon),
                        ),
                      ),
                    Text(
                      '${widget.ownerType == 'Subreddit' && widget.inProfile ? 'r' : 'u'}/${widget.inProfile ? widget.ownerName : widget.authorName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
        (widget.isMyPost)
            ? Icon(
                Icons.person,
                color: Colors.blue[600],
                size: 18,
              )
            : const SizedBox(),
        Container(
          width: 3,
          height: 3,
          margin: const EdgeInsetsDirectional.only(end: 4, start: 4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary),
        ),
        Text(
          howOld,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

/// This is class is called to make the header post widget for the home page.

class _PostHeaderHome extends StatelessWidget {
  final String authorName;
  final String ownerName;
  final String createDate;
  final String ownerIcon;
  final String ownerType;
  final bool isMyPost;
  final bool isModerator;
  const _PostHeaderHome({
    required this.isModerator,
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.ownerIcon,
    required this.isMyPost,
    required this.ownerType,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsetsDirectional.only(end: 5),
          child: CircleAvatar(
            backgroundImage: NetworkImage(ownerIcon),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                if (ownerType == 'User') {
                  showDialog(
                    context: context,
                    builder: (context) => UserInfoPopUp(
                      authorName: authorName,
                      isMine: isMyPost,
                    ),
                  );
                } else {
                  Navigator.of(context).pushNamed(
                      isModerator
                          ? ModeratedSubredditScreen.routeName
                          : SubredditScreen.routeName,
                      arguments: ownerName);
                }
              },
              child: Text(
                '${ownerType == 'Subreddit' ? 'r/' : 'u/'}$ownerName',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
            PostHeaderBasic(
              ownerType: ownerType,
              isModerator: isModerator,
              isMyPost: isMyPost,
              authorName: authorName,
              ownerName: ownerName,
              createDate: createDate,
              ownerIcon: ownerIcon,
            ),
          ],
        )
      ],
    );
  }
}
