import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import './main_modal_bottom_sheet.dart';

class ThreeDotsWidget extends StatelessWidget {
  ThreeDotsWidget(
      {Key? key,
      required this.listOfWidgets,
      required this.height,
      this.optional})
      : super(key: key);
  List<Widget> listOfWidgets;
  Widget? optional;
  double height;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: height.h * 1.5,
                child: Column(
                  children: [
                    if (optional != null) optional!,
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
          (!kIsWeb) ? Icons.more_vert : Icons.more_horiz,
          color: Colors.grey.shade600,
        ));
  }
}
