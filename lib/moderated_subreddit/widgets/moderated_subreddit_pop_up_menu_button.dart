import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/subreddit_copy_share.dart';
import '../../moderated_subreddit/providers/moderated_subreddit_provider.dart';
import '../../widgets/custom_snack_bar.dart';

class ModeratedSubredditPopupMenuButton extends StatefulWidget {
  final String linkOfCommuinty;
  final String communityName;
  final String userName;
  final bool isJoined;
  ModeratedSubredditPopupMenuButton({
    required this.linkOfCommuinty,
    required this.communityName,
    required this.userName,
    required this.isJoined,
  });
  @override
  State<ModeratedSubredditPopupMenuButton> createState() =>
      ModeratedSubredditPopupMenuButtonState();
}

class ModeratedSubredditPopupMenuButtonState
    extends State<ModeratedSubredditPopupMenuButton> {
  int? tappedIndex;
  List<String> notifyItems = ["Off", "Low", 'Frequent'];
  List<IconData?> notifyItemsIcons = [
    Icons.notifications_off,
    Icons.notifications,
    Icons.notifications_active
  ];
  bool isJoinedstate = false;
  String? dropDownValue = 'Low';
  IconData? icon = Icons.notifications;
  void initState() {
    tappedIndex = 1;
    isJoinedstate = widget.isJoined;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value.toString() == '/communitymodmessage' ||
            value.toString() == '/ModNotification') {
          Navigator.pushNamed(context, value.toString());
        } else if (value.toString() == 'Share') {
          shareCommunitySheetButton(context);
        } else if (value.toString() == 'Leave') {
          _showLeaveDialog(widget.communityName);
        } else if (value.toString() == 'join') {
          _join(widget.communityName);
        } else {
          _bellBottomSheet(context);
        }
      },
      itemBuilder: (BuildContext bc) {
        return [
          const PopupMenuItem(
            value: 'Share',
            child: ListTile(
              leading: Icon(Icons.share_outlined),
              title: Text('Share community'),
            ),
          ),
          PopupMenuItem(
            value: (!isJoinedstate) ? 'join' : 'Leave',
            child: ListTile(
              leading: Icon(
                  (!isJoinedstate) ? Icons.add_box_rounded : Icons.fast_rewind),
              title: Text((!isJoinedstate) ? 'join' : 'Leave'),
            ),
          ),
          const PopupMenuItem(
            value: '/communitymodmessage',
            child: ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Contact mods'),
            ),
          ),
          PopupMenuItem(
            value: 'Community notifications',
            child: ListTile(
              leading: Icon(icon),
              title: const Text('Community notifications'),
            ),
          ),
        ];
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }

  // ===================================this function used to===========================================//
//==================copy Link of Subreddit===========================//
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

  // ===================================the next three function used to===========================================//
//==================to disjoin of subreddit===========================//
// have two option one:leave subreddit two: cancel
//communityName==> commuintyUserName you want to leave
  void _showLeaveDialog(String communityName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        //title:Text('Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        content: Text(
            'Are you sure you want to leave the r/${communityName.toString()} community?'),
        actions: <Widget>[
          Container(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 236, 235, 235)),
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Cancel'),
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
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 242, 16, 0)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Leave'),
              onPressed: () async {
                await unSubscribe(communityName, ctx);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> unSubscribe(String communityName, BuildContext ctx) async {
    bool unSub =
        await Provider.of<ModeratedSubredditProvider>(context, listen: false)
            .joinAndDisjoinModeratedSubreddit(communityName, 'unsub', context);
    if (unSub) {
      setState(() {
        changeDisJoinStatus();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: 'Leave Successfully', disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          isError: true, text: 'Leave Failed', disableStatus: true));
    }
    Navigator.of(ctx).pop();
  }

  bool changeDisJoinStatus() {
    isJoinedstate = false;
    return isJoinedstate;
  }

  // ===================================the next two function used to===========================================//
//==================to join subreddit===========================//
//communityName==> commuintyUserName you want to join
  void _join(String communityName) async {
    bool sub = await Provider.of<ModeratedSubredditProvider>(context,
            listen: false)
        .joinAndDisjoinModeratedSubreddit(widget.communityName, 'sub', context);
    if (sub) {
      setState(() {
        changeJoinStatus();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: 'Join Successfully', disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(isError: true, text: 'Join Failed', disableStatus: true),
      );
    }
  }

  bool changeJoinStatus() {
    isJoinedstate = true;
    return isJoinedstate;
  }

//to change Notification mode
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
                    itemCount: notifyItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: ListTile(
                        leading: Icon(
                          size: 25,
                          notifyItemsIcons[index],
                          color:
                              tappedIndex == index ? Colors.black : Colors.grey,
                        ),
                        trailing: Visibility(
                          visible: tappedIndex == index,
                          child: const Icon(
                            Icons.done,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          notifyItems[index],
                          style: TextStyle(
                              color: tappedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            chooseNotificationType(index);
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

  int chooseNotificationType(int index) {
    dropDownValue = notifyItems[index];
    tappedIndex = index;
    icon = notifyItemsIcons[index] as IconData;
    return tappedIndex as int;
  }
}
