import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/sort_bottom_web.dart';
import '../models/others_profile_data.dart';
import 'position_other_profile_web.dart';
import '../widgets/other_profile_card_information_web.dart';
class OverviewMyProfileWeb extends StatefulWidget {
    final OtherProfileData loadProfile;
  const OverviewMyProfileWeb({
    Key? key,
     required this.loadProfile,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<OverviewMyProfileWeb> createState() => _OverviewMyProfileWebState();
}
class _OverviewMyProfileWebState extends State<OverviewMyProfileWeb> {
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
                  // SizedBox(height: 4.h,),
                  Container(
                    height: 6.h,
                    width: 50.w,
                    margin: EdgeInsets.only(left: 100, bottom: 10, top: 30),
                    child: SortBottomWeb(),
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
            OtherProfileCardInformationWeb(loadProfile: widget.loadProfile),
            
          ],
        ),
      ],
    );
  }
}


