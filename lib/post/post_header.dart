import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final bool inProfile;
  final bool inHome;
  final String userName;
  final String communityName;
  final String createDate;
  const PostHeader(
      {super.key,
      this.inProfile = false,
      this.inHome = false,
      required this.userName,
      required this.communityName,
      required this.createDate});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      padding: const EdgeInsetsDirectional.only(start: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          inHome
              ? _PostHeaderHome(
                  userName: userName,
                  communityName: communityName,
                  createDate: createDate,
                )
              : _PostHeaderBasic(
                  inProfile: inProfile,
                  userName: userName,
                  communityName: communityName,
                  createDate: createDate,
                ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).colorScheme.secondary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _PostHeaderBasic extends StatelessWidget {
  final bool inProfile;
  final String userName;
  final String communityName;
  final String createDate;
  const _PostHeaderBasic(
      {this.inProfile = false,
      required this.userName,
      required this.communityName,
      required this.createDate});
  @override
  Widget build(BuildContext context) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(createDate));
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
    return Row(
      children: [
        if (inProfile)
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsetsDirectional.only(end: 2),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/community_icon.png'),
            ),
          ),
        Text('${inProfile ? 'r' : 'u'}/${inProfile ? communityName : userName}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
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

class _PostHeaderHome extends StatelessWidget {
  final String userName;
  final String communityName;
  final String createDate;
  const _PostHeaderHome(
      {required this.userName,
      required this.communityName,
      required this.createDate});
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
              'r/$communityName',
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            _PostHeaderBasic(
              userName: userName,
              communityName: communityName,
              createDate: createDate,
            ),
          ],
        )
      ],
    );
  }
}
