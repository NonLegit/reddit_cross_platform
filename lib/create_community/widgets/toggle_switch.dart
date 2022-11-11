import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleSwitch extends StatelessWidget {
  ToggleSwitch(
      {Key? key, required this.plus18Community, required this.toggleSwitch})
      : super(key: key);

  final bool plus18Community;
  Function(bool) toggleSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      //==> extract to widget
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('18+ community',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        FlutterSwitch(
          value: plus18Community,
          width: 7.h,
          height: 4.h,
          activeColor: Colors.blue,
          onToggle: toggleSwitch,
        )
      ],
    );
  }
}
