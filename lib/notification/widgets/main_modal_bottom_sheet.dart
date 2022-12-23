import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class MainModalBottomSheet extends StatelessWidget {
  MainModalBottomSheet({super.key, required this.listOfWidgets});
  List<Widget> listOfWidgets;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20.h,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            ListView.builder(
              
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return listOfWidgets[index];
              },
              itemCount: listOfWidgets.length,
            )
          ],
        ),
      ),
    );
  }
}
