import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../providers/subreddit_provider.dart';
import 'package:provider/provider.dart';
import '../../models/subreddit_data.dart';

class SubredditCardInformationWeb extends StatefulWidget {
  final SubredditData? loadedSubreddit;
  const SubredditCardInformationWeb({
    Key? key,
    required this.loadedSubreddit,
  }) : super(key: key);

  @override
  State<SubredditCardInformationWeb> createState() =>
      _SubredditCardInformationWebState();
}

class _SubredditCardInformationWebState
    extends State<SubredditCardInformationWeb> {
  bool chooseTheme = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 180, top: 100),
     width: 50.w,
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.h,
              height: 6.h,
              padding: const EdgeInsets.only(top: 20, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: const Text(
                'About Community',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 100.h,
              height: 32.h,
              padding: const EdgeInsets.only(top: 20, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.loadedSubreddit!.description}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.cake_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        '${DateFormat.yMMMMd('en_US').format(DateTime.parse(widget.loadedSubreddit!.createdAt.toString()))}',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${new NumberFormat.compact().format(widget.loadedSubreddit!.numOfMembers)}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
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
                                const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      end: 2, bottom: 2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 4,
                                  ),
                                ),
                                Text(
                                  '${new NumberFormat.compact().format(widget.loadedSubreddit!.numOfOnlines)
                                  //loadedSubreddit!.numOfMembers
                                  }',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Text(
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
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(top: 10, right: 6),
                    width: 100.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                      child: const Text(
                        'Create Post',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: (chooseTheme)
                        ? Icon(Icons.visibility_outlined)
                        : Icon(Icons.visibility_off_outlined),
                    title: Text('Community theme'),
                    trailing: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade400,
                      splashRadius: 50.0,
                      value: chooseTheme,
                      onChanged: (value) {
                        setState(() => chooseTheme = value);
                        Provider.of<SubredditProvider>(context, listen: true)
                            .togglingTheme();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
