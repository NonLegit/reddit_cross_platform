import 'package:flutter/material.dart';
import '../models/status.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/upper_bar.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);
  static const routeName = '/Gender';
  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [UpperBar(UpperbarStatus.skip)],
      ),
    );
  }
}
