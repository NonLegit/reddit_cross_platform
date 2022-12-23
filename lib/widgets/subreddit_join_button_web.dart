import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../subreddit/providers/subreddit_provider.dart';
import '../subreddit/widgets/notify_button_web.dart';
import '../../widgets/custom_snack_bar.dart';

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

  Future<void> subscribe(BuildContext context) async {
    print(
        '===============================Subcribe==================================');
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
    isJoinedstate = false;
    return isJoinedstate;
  }

  Future<void> unSubescribe(BuildContext ctx) async {
    print(
        '===============================Un Subcribe==================================');
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
