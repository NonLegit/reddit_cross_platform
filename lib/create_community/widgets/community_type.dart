import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'bar_widget.dart';
import 'modal_bottom_sheet.dart';

class CommunityType extends StatelessWidget {
  CommunityType({
    Key? key,
    required this.communityType,
    required this.communityTypeIcon,
    required this.getCommunityType,
  }) : super(key: key);

  final Map<String, String> communityType;
  final Map<String, IconData> communityTypeIcon;
  Function getCommunityType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Column(
        children: [
          const Divider(
            color: Colors.transparent,
          ),
          const BarWidget(),
          const Divider(
            color: Colors.transparent,
          ),
          const Text(
            'Community type',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var key2 = communityType.keys.elementAt(index);
              return GestureDetector(
                //Calls getCommunityType to change choosen community
                onTap: () => getCommunityType(key2),
                //Calls widget ModalBottomSheetContent to build modal bottom sheet UI
                // key2 : Type of community
                // communityTypeIcon : Icon of community type
                // community type :Definition of each community
                child: ModalBottomSheetContent(
                    key2: key2,
                    communityTypeIcon: communityTypeIcon,
                    communityType: communityType),
              );
            },
            itemCount: communityType.length,
          ),
        ],
      ),
    );
  }
}
