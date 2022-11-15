import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

import './main_modal_bottom_sheet.dart';

class ThreeDotsWidget extends StatelessWidget {
  ThreeDotsWidget({Key? key, required this.listOfWidgets, required this.height, this.optional})
      : super(key: key);
  List<Widget> listOfWidgets;
  Widget? optional;
  int height;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: height.h,
                child: Column(
                  children: [
                    if(optional != null) optional!,
                    MainModalBottomSheet(
                      listOfWidgets: listOfWidgets,
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey.shade600,
        ));
  }
}
