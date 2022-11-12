import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClearTextField extends StatelessWidget {
  ClearTextField(
      {Key? key,
      required this.typed,
      required this.clearTextField,
      required this.count})
      : super(key: key);

  int count;
  bool typed;
  VoidCallback clearTextField;

  @override
  Widget build(BuildContext context) {
    return Container(
      //=> extract to widget
      width: 15.h,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(count.toString()),
          if (typed)
            IconButton(
                onPressed: clearTextField,
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ))
        ],
      ),
    );
  }
}
