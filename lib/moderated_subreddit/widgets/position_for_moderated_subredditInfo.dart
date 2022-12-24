import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/moderation_settings/screens/moderator_tools_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/subreddit_data.dart';
class PositionForModeratedSubredditInfo extends StatelessWidget {
  final SubredditData? loadedSubreddit;
  final String? userName;
  PositionForModeratedSubredditInfo({
    required this.loadedSubreddit,
    required this.userName,
    Key? key,
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
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ListTile(
                    title: Text('r/${loadedSubreddit!.name.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '${myFormat.format(int.parse(loadedSubreddit!.numOfMembers.toString()))} members .${myFormat.format(int.parse(loadedSubreddit!.numOfOnlines.toString()))} online ',
                    ),
                    trailing: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 9, 149, 104)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)))),
                        ),
                        child: Row(
                          children: const [
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    '${loadedSubreddit!.description.toString()}',
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          )),
    );
  }
}
