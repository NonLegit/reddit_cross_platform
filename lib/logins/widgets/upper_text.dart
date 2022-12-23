import 'package:flutter/material.dart';

class UpperText extends StatelessWidget {
  ///text that will be appare
  final String data;
  const UpperText(this.data, {super.key});
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
