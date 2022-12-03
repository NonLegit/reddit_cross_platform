import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class CommunityTypeWeb extends StatelessWidget {
   CommunityTypeWeb({
    super.key,
    required this.communityType,
    required this.selectedIndex,
    required this.communityTypeIconWeb,
    required this.onClick,
  });

  final Map<String, String> communityType;
  final int selectedIndex;
  final Map<String, IconData> communityTypeIconWeb;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.h,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String type =
                  communityType.keys.elementAt(index);
              return GestureDetector(
                onTap: () => onClick(index,type),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: [
                        Icon(
                          (selectedIndex == index)
                              ? Icons.radio_button_on
                              : Icons.radio_button_off,
                          size: 17,
                          color: (selectedIndex == index)
                              ? Colors.blue
                              : Colors.black45,
                        ),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Icon(
                          communityTypeIconWeb[type],
                          size: 20,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 0.9.w,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: type,
                            style: TextStyle(fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text: communityType[type],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                  ],
                ),
              );
              ;
            },
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
