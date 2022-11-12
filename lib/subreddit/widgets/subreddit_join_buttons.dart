import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JoinButtons extends StatefulWidget {
  int? tappedIndex;
  List<String> notifyItems = ["Off", "Low", 'Frequent'];
  List<IconData?> notifyItemsIcons = [
    Icons.notifications_off,
    Icons.notifications,
    Icons.notifications_active
  ];
  bool isJoined;
  String dropDownValue;
  String communityName;
  IconData icon;
  JoinButtons(
      {required this.isJoined,
      required this.icon,
      required this.dropDownValue,
      required this.communityName});

  @override
  State<JoinButtons> createState() => JoinButtonsState();
}

class JoinButtonsState extends State<JoinButtons> {
  @override
  void initState() {
    super.initState();
    widget.tappedIndex = 0;
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
            (widget.isJoined)
                ? IconButton(
                    onPressed: () => bellBottomSheet(context),
                    icon: Icon(
                      size: 30,
                      widget.icon,
                      color: Colors.blue,
                    ))
                : SizedBox(
                    width: 10.w,
                  ),
            Container(
              width: 21.w,
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
                child: (widget.isJoined)
                    ? Text(
                        'Joined',
                        style: TextStyle(fontSize: 13),
                      )
                    : Text('Join'),
                onPressed: () {
                  if (widget.isJoined) {
                    _showLeaveDialog();
                  } else {
                    setState(() {
                      widget.isJoined = true;
                    });
                  }
                },
              ),
            ),
          ],
        ));
  }

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
                joinButtonFunc();
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }

 bool  joinButtonFunc() {
    setState(() {
                widget.isJoined = false;
              });
         return widget.isJoined;
  }
}
