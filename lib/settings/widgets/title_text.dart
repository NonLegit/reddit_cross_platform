import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleText extends StatelessWidget {
  // const TitleText({Key? key}) : super(key: key);
  final String lable;
  TitleText({this.lable = ''});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5.h),
      child: Text(
          style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500),
          lable),
    );
  }
}
