import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/sort_bottom_web.dart';
import '../../models/subreddit_data.dart';
import '../widgets/subreddit_card_information_web.dart';
class SubredditePostWeb extends StatefulWidget {
  final SubredditData? loadedSubreddit;
  const SubredditePostWeb({
    Key? key,
    required this.loadedSubreddit,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<SubredditePostWeb> createState() => _SubredditePostWebState();
}

class _SubredditePostWebState extends State<SubredditePostWeb> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: SortBottomWeb(),
                    color: Colors.white,
                    // width: 100.w,
                  ),
                  Container(
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
            Expanded(
                child: SubredditCardInformationWeb(loadedSubreddit: widget.loadedSubreddit,)),
          ],
        ),
      ],
    );
  }
}

