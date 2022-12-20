import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../models/subreddit_data.dart';
import '../widgets/subreddit_join_buttons.dart';
class PostionForSubredditInfo extends StatelessWidget {
  SubredditData loadedSubreddit;
   PostionForSubredditInfo({
    Key? key,
   required this.loadedSubreddit
  }) : super(key: key);
 NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      right: 0,
      left: 0,
      bottom: 0,
      child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 100.w,
                height: 9.h,
                child: ListTile(
                  title: Text('r/${loadedSubreddit.name.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                  '${myFormat.format(int.parse(loadedSubreddit.numOfMembers.toString()))} members .${myFormat.format(int.parse(loadedSubreddit.numOfOnlines.toString()))} online ',

                  ),
                  trailing: JoinButtons(
                      isJoined: loadedSubreddit.isJoined as bool,
                       communityuserName: loadedSubreddit.name.toString(),
                      ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    '${loadedSubreddit.description.toString()}',
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          )),
    );
  }
}