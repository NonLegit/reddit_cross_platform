import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/subreddit_copy_share.dart';
import '../../subreddit/screens/subreddit_screen.dart';

class ModeratedSubredditPopupMenuButton extends StatefulWidget {
  final String linkOfCommuinty;
  final String communityName;
  final String userName;
  int? tappedIndex;
  List<String> notifyItems = ["Off", "Low", 'Frequent'];
  List<IconData?> notifyItemsIcons = [
    Icons.notifications_off,
    Icons.notifications,
    Icons.notifications_active
  ];
  bool? isJoined;
  String? dropDownValue;
  IconData? icon;
  ModeratedSubredditPopupMenuButton(
      {required this.linkOfCommuinty,
      required this.communityName,
      required this.userName});
  @override
  State<ModeratedSubredditPopupMenuButton> createState() =>
      _ModeratedSubredditPopupMenuButtonState();
}

class _ModeratedSubredditPopupMenuButtonState
    extends State<ModeratedSubredditPopupMenuButton> {
  void initState() {
    super.initState();
    widget.tappedIndex = 0;
  }

  // var selectedItem = '';
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(onSelected: (value) {
      // your logic
      // setState(() {
      //   selectedItem = value.toString();
      // });
      if (value.toString() == '/communitymodmessage' ||
          value.toString() == '/ModNotification')
        Navigator.pushNamed(context, value.toString());
      else if (value.toString() == 'Share')
        shareCommunitySheetButton(context);
      else if (value.toString() == 'Leave')
        _showLeaveDialog();
      else
        _bellBottomSheet(context);
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
            leading: Icon(Icons.fast_rewind),
            title: Text('Leave'),
          ),
          value: 'Leave',
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
            leading: Icon(Icons.notifications_none_outlined),
            title: Text('Community notifications'),
          ),
          value: 'Community notifications',
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.notifications_none_outlined),
            title: Text('Manage mod notifications'),
          ),
          value: '/ModNotification',
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

  void _showLeaveDialog() {
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
                setState(() {
                  widget.isJoined = false;
                });
                Navigator.pushNamed(
                    context, SubredditScreen.routeName,
                    arguments:widget.userName);
                //Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _bellBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.height * 0.35,
            // width: MediaQuery.of(context).size.width * 0.30,
            height: 35.h,
            width: 30.w,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('COMMUNITY NOTIFICATIONS',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                const Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.notifyItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: ListTile(
                        leading: Icon(
                          size: 25,
                          widget.notifyItemsIcons[index],
                          color: widget.tappedIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                        trailing: Visibility(
                          visible: widget.tappedIndex == index,
                          child: const Icon(
                            Icons.done,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          widget.notifyItems[index],
                          style: TextStyle(
                              color: widget.tappedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            widget.dropDownValue = widget.notifyItems[index];
                            widget.tappedIndex = index;
                            widget.icon =
                                widget.notifyItemsIcons[index] as IconData;
                          });
                          return Navigator.pop(context);
                        },
                      ));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
