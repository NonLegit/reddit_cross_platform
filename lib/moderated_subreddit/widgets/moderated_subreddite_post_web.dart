import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/sort_bottom_web.dart';
import '../../models/subreddit_data.dart';
import '../widgets/moderated_subreddit_card_information_web.dart';
class ModeratedSubredditePostWeb extends StatefulWidget {
  final SubredditData? loadedSubreddit;
  const ModeratedSubredditePostWeb({
    Key? key,
    required this.loadedSubreddit,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State< ModeratedSubredditePostWeb> createState() => _ModeratedSubredditePostWebState();
}

class _ModeratedSubredditePostWebState extends State<ModeratedSubredditePostWeb> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 6.h,
                    width: 50.w,
                    margin: EdgeInsets.only(left: 100, top: 40),
                    child: SortBottomWeb(page: 1,userName: widget.loadedSubreddit!.name.toString(),),
                    color: Colors.white,
                    // width: 100.w,
                  ),
                  Container(
                    // padding: const EdgeInsets.only(bottom: 100,),
                    margin: EdgeInsets.only(left: 100, bottom: 90, top: 30),
                    height: 30.h,
                    width: 50.w,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        )),
                    child: Column(children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Expanded(
                              child: ListTile(
                                title: Text('Post'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            ModeratedSubredditCardInformationWeb(loadedSubreddit: widget.loadedSubreddit),
          ],
        ),
      ],
    );
  }
}

