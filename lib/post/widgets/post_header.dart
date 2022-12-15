import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_popup_menu.dart';
import 'package:post/post/widgets/user_info_popup.dart';
import 'package:post/subreddit/screens/subreddit_screen.dart';

/// This Widget is responsible for the header of the post.

class PostHeader extends StatelessWidget {
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
  const PostHeader({
    super.key,
    this.inProfile = false,
    this.inHome = false,
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.isSaved,
    required this.ownerIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 15, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            inHome
                ? _PostHeaderHome(
                    authorName: authorName,
                    ownerName: ownerName,
                    createDate: createDate,
                    ownerIcon: ownerIcon,
                  )
                : PostHeaderBasic(
                    inProfile: inProfile,
                    authorName: authorName,
                    ownerName: ownerName,
                    createDate: createDate,
                    ownerIcon: ownerIcon,
                  ),
            PostPopupMenu(
              isSaved: isSaved,
            ),
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
  const PostHeaderBasic({
    this.inProfile = false,
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.ownerIcon,
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
        InkWell(
          onTap: (!widget.inProfile)
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) => UserInfoPopUp(
                      authorName: widget.authorName,
                    ),
                  );
                }
              : () => Navigator.of(context).pushNamed(SubredditScreen.routeName,
                  arguments: widget.ownerName),
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
                '${widget.inProfile ? 'r' : 'u'}/${widget.inProfile ? widget.ownerName : widget.authorName}',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
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

  const _PostHeaderHome({
    required this.authorName,
    required this.ownerName,
    required this.createDate,
    required this.ownerIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsetsDirectional.only(end: 5),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/community_icon.png'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'r/$ownerName',
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            PostHeaderBasic(
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
