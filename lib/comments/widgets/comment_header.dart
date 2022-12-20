import 'package:flutter/material.dart';

import '../../post/widgets/user_info_popup.dart';

class CommentHeader extends StatefulWidget {
  final String authorName;
  final String authorIcon;
  final String userName;
  final String date;
  const CommentHeader(
      {super.key,
      required this.authorName,
      required this.authorIcon,
      required this.userName,
      required this.date});

  @override
  State<CommentHeader> createState() => _CommentHeaderState();
}

class _CommentHeaderState extends State<CommentHeader> {
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
  Widget build(BuildContext context) {
    String howOld = calculateHowOld(widget.date);
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => UserInfoPopUp(
                isMine: widget.authorName == widget.userName,
                authorName: widget.authorName,
              ),
            );
          },
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                margin: const EdgeInsetsDirectional.only(end: 8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.authorIcon),
                ),
              ),
              Text(
                '${widget.authorName}',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              (widget.userName == widget.authorName)
                  ? Icon(
                      Icons.person,
                      color: Colors.blue[600],
                      size: 18,
                    )
                  : const SizedBox(),
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
