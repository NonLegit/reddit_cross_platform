import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      width: 7.h,
      height: 0.5.h,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey),
    );
  }
}