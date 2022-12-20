import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmptySearch extends StatelessWidget {
  String message;
  EmptySearch({super.key, this.message = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          const Icon(
            Icons.reddit,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
