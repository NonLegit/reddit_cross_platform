import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class WebImageLoging extends StatelessWidget {
  const WebImageLoging({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/reddit-logins.png',
      width: 10.w,
      height: 100.h,
      fit: BoxFit.fill,
    );
  }
}
