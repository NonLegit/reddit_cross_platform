import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Create a community',
      ),
      titleTextStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
      backgroundColor: Colors.grey[50],
      titleSpacing: 0,
      elevation: 2,
      shadowColor: Colors.white,
    );
  }
}
