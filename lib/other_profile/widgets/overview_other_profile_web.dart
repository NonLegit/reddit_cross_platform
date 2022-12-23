import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/sort_bottom_web.dart';
import '../models/others_profile_data.dart';
import '../widgets/other_profile_card_information_web.dart';

class OverviewOtherProfileWeb extends StatefulWidget {
  final OtherProfileData loadProfile;
    final ScrollController scrollController;
 OverviewOtherProfileWeb({
    Key? key,
        required this.scrollController,
    required this.loadProfile,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<OverviewOtherProfileWeb> createState() => _OverviewOtherProfileWebState();
}

class _OverviewOtherProfileWebState extends State<OverviewOtherProfileWeb> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
       controller: widget.scrollController,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    height: 6.h,
                    width: 50.w,
                    margin: EdgeInsets.only(left: 100, bottom: 10, top: 30),
                    child: SortBottomWeb(page: 1 ,userName: widget.loadProfile.userName.toString()),
                    color: Colors.white,
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
            OtherProfileCardInformationWeb(loadProfile: widget.loadProfile),
          ],
        ),
      ],
    );
  }
}
