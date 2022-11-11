import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              width: 35.h,
              height: 35.h,
              child: Card(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      style: Theme.of(context).textTheme.headline4,
                      'this is the new screen for gender'),
                ),
                color: Color.fromARGB(255, 228, 231, 239),
              ))),
    );
  }
}
