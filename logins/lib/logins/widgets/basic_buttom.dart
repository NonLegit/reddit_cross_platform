import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BasicBottom extends StatelessWidget {
  final String lable;
  final Function handler;
  const BasicBottom({this.lable = '', required this.handler});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: .5.h),
      child: ElevatedButton(
        onPressed: () {
          handler();
        },
        child: Text(lable),
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 228, 231, 239),
            // side: BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
      ),
    );
  }
}
