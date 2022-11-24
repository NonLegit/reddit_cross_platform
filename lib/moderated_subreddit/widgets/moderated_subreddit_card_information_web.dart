import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/moderated_subreddit_data.dart';

class ModeratedSubredditCardInformationWeb extends StatelessWidget {
  const ModeratedSubredditCardInformationWeb({
    Key? key,
    required this.loadedSubreddit,
  }) : super(key: key);

  final ModeratedSubredditData? loadedSubreddit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(right: 180, top: 100),
            width: 60.w,
            height: 32.h,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: 100.h,
                  height: 6.h,
                  padding: EdgeInsets.only(top: 10,left: 10),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Community',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 7.h,),
                      ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'MOD TOOLS',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ))
                    ],
                  ),
                  color: Colors.blue,
                ),
                Container(
                  width: 100.h,
                  height: 26.h,
                  padding: EdgeInsets.only(top: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${loadedSubreddit!.description}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.cake_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Created Apr 30, 2013',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${new NumberFormat.compact().format(loadedSubreddit!.numOfMembers)
                                  //loadedSubreddit!.numOfMembers
                                  }',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Members',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 2, bottom: 2),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 4,
                                      ),
                                    ),
                                    Text(
                                      '${new NumberFormat.compact().format(loadedSubreddit!.numOfOnlines)
                                      //loadedSubreddit!.numOfMembers
                                      }',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Online',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(top: 10, right: 6),
                        width: 100.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22)))),
                          ),
                          child: Text(
                            'Create Post',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                )
              ],
            )));
  }
}
