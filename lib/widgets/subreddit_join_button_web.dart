import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../subreddit/widgets/notify_button_web.dart';
class SubredditJoinButtonWeb extends StatefulWidget {
  bool isJoined;
  //String dropDownValue;
  String communityName;
  //IconData icon;
  SubredditJoinButtonWeb(
      {required this.isJoined,
      //required this.icon,
      //required this.dropDownValue,
      required this.communityName});

  @override
  State<SubredditJoinButtonWeb> createState() => SubredditJoinButtonWebState();
}

class SubredditJoinButtonWebState extends State<SubredditJoinButtonWeb> {

  var tappedIndex = 1;
  bool isJoinedstate = false;
  @override
  void initState() {
    super.initState();
    tappedIndex = 1;
    isJoinedstate = widget.isJoined;
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
            SizedBox(
              width: 3.w,
            ),
            Container(
              width: 8.w,
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
                    disJoin();
                  } else {
                    setState(() {
                      isJoinedstate = true;
                    });
                  }
                },
              ),
            ),
            (isJoinedstate)
                ? NotifyButtonWeb()     : SizedBox(
                    width: 10.w,
                  ),
          ],
        ));
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
