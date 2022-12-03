import 'package:flutter/material.dart';
import 'package:post/moderation_settings/screens/moderator_tools_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/moderated_subreddit_data.dart';

class PositionForModeratedSubredditInfo extends StatelessWidget {
  final ModeratedSubredditData? loadedSubreddit;
  final String? userName;
  PositionForModeratedSubredditInfo({
    required this.loadedSubreddit,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
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
                    title: Text('r/${loadedSubreddit!.name.toString()}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '${int.parse(loadedSubreddit!.numOfMembers.toString())} members .${int.parse(loadedSubreddit!.numOfOnlines.toString())} online ',
                    ),
                    trailing: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: 35.w,
                      height: 4.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 9, 149, 104)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)))),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: Colors.white,
                            ),
                            Text('Mod Tools'),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              ModeratorTools.routeName,
                              arguments: userName);
                        },
                      ),
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    '${loadedSubreddit!.description.toString()}',
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          )),
    );
  }
}
