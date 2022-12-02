import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class EmptyScreen extends StatefulWidget {
  // const EmptyScreen({Key? key}) : super(key: key);
  static const routeName = '/EmptyScreen';
  final String title;
  EmptyScreen({this.title = ''});
  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 40.h,
          height: 40.h,
          child: Card(
            color: Color.fromARGB(255, 228, 231, 239),
            child: Center(
                child: Text(
                    style: TextStyle(fontSize: 20),
                    'this screen is still empty')),
          ),
        ),
      ),
    );
  }
}
