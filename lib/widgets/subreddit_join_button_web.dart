import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../subreddit/providers/subreddit_provider.dart';
import '../subreddit/widgets/notify_button_web.dart';
import './custom_snack_bar.dart';

class SubredditJoinButtonWeb extends StatefulWidget {
  bool isJoined;
  String communityName;
  SubredditJoinButtonWeb(
      {required this.isJoined,
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
              margin: const EdgeInsets.only(top: 8),
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.blue)),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)))),
                ),
                child: (isJoinedstate)
                    ? const Text(
                        'Joined',
                        style: TextStyle(fontSize: 13),
                      )
                    : const Text('Join'),
                onPressed: () async {
                  if (isJoinedstate) {
                    unSubescribe(context);
                  } else {
                    subscribe(context);
                    setState(() {
                      isJoinedstate = true;
                    });
                  }
                },
              ),
            ),
            (isJoinedstate)
                ? NotifyButtonWeb()
                : SizedBox(
                    width: 10.w,
                  ),
          ],
        ));
  }
 // ===================================the next two function used to===========================================//
//==================to join subreddit===========================//
//communityName==> commuintyUserName you want to join

  Future<void> subscribe(BuildContext context) async {
       bool sub = await Provider.of<SubredditProvider>(context, listen: false)
        .joinAndDisjoinSubreddit(widget.communityName, 'sub', context);
    if (sub) {
      setState(() {
        join();
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

  bool join() {
    isJoinedstate = true;
    return isJoinedstate;
  }
 // ===================================the next three function used to===========================================//
//==================to disjoin of subreddit===========================//
// have two option one:leave subreddit two: cancel
//communityName==> commuintyUserName you want to leave
 
  Future<void> unSubescribe(BuildContext ctx) async {
      bool unSub = await Provider.of<SubredditProvider>(context, listen: false)
        .joinAndDisjoinSubreddit(widget.communityName, 'unsub', context);
    if (unSub) {
      setState(() {
        disJoin();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: 'Leave Successfully', disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          isError: true, text: 'Leave Failed', disableStatus: true));
    }
  }

  bool disJoin() {
    isJoinedstate = false;
    return isJoinedstate;
  }
}
