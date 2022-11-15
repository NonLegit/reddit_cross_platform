import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class LoadingReddit extends StatelessWidget {
  const LoadingReddit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(

            child: Image.asset(
          'assets/images/loadingreddit.gif',

          width: 20.w,
          height: 20.h,
        )),
      );
  }
}
