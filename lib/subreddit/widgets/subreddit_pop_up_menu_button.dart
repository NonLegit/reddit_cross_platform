import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/subreddit_copy_share.dart';

class SubredditPopupMenuButton extends StatefulWidget {
  final String linkOfCommuinty;
  final String communityName;
   final String userName;
  SubredditPopupMenuButton(this.linkOfCommuinty, this.communityName,this.userName);
  @override
  State<SubredditPopupMenuButton> createState() =>
      _SubredditPopupMenuButtonState();
}

class _SubredditPopupMenuButtonState extends State<SubredditPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
      if (value.toString() == '/communitymodmessage' 
      ) {
        Navigator.pushNamed(context, value.toString());
      } else if (value.toString() == 'Share') {
        shareCommunitySheetButton(context);
      }
    }, itemBuilder: (BuildContext bc) {
      return const [
        PopupMenuItem(
          value: 'Share',
          child: ListTile(
            leading: Icon(Icons.share_outlined),
            title: Text('Share community'),
          ),
        ),
        PopupMenuItem(
          value: '/communitymodmessage',
          child: ListTile(
            leading: Icon(Icons.mail_outline),
            title: Text('Contact mods'),
          ),
        ),
      ];
    },
    icon: const Icon(Icons.more_vert,color: Colors.white,),
    );
  }
// to copy Link of Subreddit
//by using copy clipboard
  Future<void> shareCommunitySheetButton(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: CopyShare(link: widget.linkOfCommuinty.toString()),
        );
      },
    );
  }

}
