import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class barWidget extends StatelessWidget {
  const barWidget({
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
