import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JoinButtons extends StatefulWidget {

  bool isJoined;
  //String dropDownValue;
  String communityName;
  //IconData icon;
  JoinButtons(
      {
      required this.isJoined,
      //required this.icon,
      //required this.dropDownValue,
      required this.communityName});

  @override
  State<JoinButtons> createState() => JoinButtonsState();
}

class JoinButtonsState extends State<JoinButtons> {
    String dropDownValue = "Low";
  IconData icon = Icons.notifications;
  var tappedIndex = 1;
  bool isJoinedstate = false;
  static const List<String> notifyItems = ["Off", "Low", 'Frequent'];
  static List<IconData> notifyItemsIcons = [
    Icons.notifications_off,
    Icons.notifications,
    Icons.notifications_active
  ];
  @override
  void initState() {
     tappedIndex = 1;
    isJoinedstate = widget.isJoined;
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35.w,
        height: 6.h,
        // color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isJoinedstate)
                ? IconButton(
                    onPressed: () => bellBottomSheet(context),
                    icon: Icon(
                      size: 30,
                      icon,
                      color: Colors.blue,
                    ))
                : SizedBox(
                    width: 10.w,
                  ),
            Container(
              width: 20.w,
              height: 5.h,
              margin: EdgeInsets.only(top: 8),
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.blue)),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)))),
                ),
                child: (isJoinedstate)
                    ? Text(
                        'Joined',
                        style: TextStyle(fontSize: 13),
                      )
                    : Text('Join'),
                onPressed: () {
                  if (isJoinedstate) {
                    _showLeaveDialog();
                  } else {
                    setState(() {
                      isJoinedstate = true;
                    });
                  }
                },
              ),
            ),
          ],
        ));
  }
// Change Notification Mod  of subreddit
  Future<void> bellBottomSheet(BuildContext context) {
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
                          color: tappedIndex == index
                              ? Colors.black
                              : Colors.grey,
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
                            changeNotificationMode(index);
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
  int changeNotificationMode(int index) {
    icon = notifyItemsIcons[index] as IconData;
    dropDownValue = notifyItems[index];
    tappedIndex = index;

    return  tappedIndex;
  }
  //to Disjoin from subreddit
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
                  disJoin();
                });
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }
  bool disJoin() {
    isJoinedstate = false;
    return isJoinedstate;
  }
}
