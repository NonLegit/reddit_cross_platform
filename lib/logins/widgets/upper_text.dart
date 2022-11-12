import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class UpperText extends StatelessWidget {
  // const UpperText({Key? key}) : super(key: key);
  final String data;
  UpperText(this.data);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          data),
    );
  }
}
