import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SortBottomWeb extends StatefulWidget {
  final int _limit = 25;
  final int page;
  final String userName;
  SortBottomWeb({
    required this.page,
    required this.userName,
  });
  @override
  State<SortBottomWeb> createState() => SortBottomWebState();
}

class SortBottomWebState extends State<SortBottomWeb> {
  List<bool> litems = [false, false, false];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10.h,
        width: 50.w,
       // margin: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                  color: Colors.white,
                  // width: 10.w,
                  height: 8.h,
                 // margin: const EdgeInsets.only(left: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                NewButton();
                              });
                              await Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .fetchandSetProfilePostsAndComments(
                                      widget.userName.toString(),
                                      'New',
                                      widget.page,
                                      25,
                                      context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.brightness_low,
                                    color:
                                        litems[0] ? Colors.blue : Colors.grey),
                                Text(
                                  'New',
                                  style: TextStyle(
                                      color: litems[0]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                HotButton();
                              });
                              await Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .fetchandSetProfilePostsAndComments(
                                      widget.userName.toString(),
                                      'Hot',
                                      widget.page,
                                      25,
                                      context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.local_fire_department_rounded,
                                    color:
                                        litems[1] ? Colors.blue : Colors.grey),
                                Text(
                                  'Hot',
                                  style: TextStyle(
                                      color: litems[1]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                TopButton();
                              });
                              await Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .fetchandSetProfilePostsAndComments(
                                      widget.userName.toString(),
                                      'Top',
                                      widget.page,
                                      25,
                                      context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.hourglass_empty,
                                    color:
                                        litems[2] ? Colors.blue : Colors.grey),
                                Text(
                                  'Top',
                                  style: TextStyle(
                                      color: litems[2]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                      ])),
            )
          ],
        ));
  }

  bool TopButton() {
    litems = [false, false, true];
    return litems[2];
  }

  bool HotButton() {
    litems = [false, true, false];
    return litems[1];
  }

  bool NewButton() {
    litems = [true, false, false];
    return litems[0];
  }
}
