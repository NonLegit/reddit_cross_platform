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
  // var selectedItem = '';
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(onSelected: (value) {
      // your logic
      // setState(() {
      //   selectedItem = value.toString();
      // });
      if (value.toString() == '/communitymodmessage' ||
          value.toString() == '/communityinfo')
        Navigator.pushNamed(context, value.toString());
      else if (value.toString() == 'Share')
        shareCommunitySheetButton(context);
      else
        _showLeaveDialog('message');
    }, itemBuilder: (BuildContext bc) {
      return const [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.share_outlined),
            title: Text('Share community'),
          ),
          value: 'Share',
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.report_outlined),
            title: Text('Community info'),
          ),
          value: '/communityinfo',
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.mail_outline),
            title: Text('Contact mods'),
          ),
          value: '/communitymodmessage',
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.fast_rewind),
            title: Text('Leave'),
          ),
          value: 'Leave',
        )
      ];
    });
  }

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

  void _showLeaveDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        //title:Text('Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        content: Text(
            'Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        actions: <Widget>[
          Container(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 236, 235, 235)),
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ),
          Container(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 242, 16, 0)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: Text('Leave'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
