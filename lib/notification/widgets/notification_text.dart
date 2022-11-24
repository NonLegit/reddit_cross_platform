import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationText extends StatelessWidget {
  NotificationText(
      {super.key,
      required this.description,
      required this.time,
      required this.text,
      required this.image,
      this.button,
      this.index});
  String text;
  String time;
  String description;
  Widget image;
  Widget? button;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        SizedBox(
          width: 2.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  maxLines: 2,
                ),
                SizedBox(
                  width: 2.w,
                ),
                const Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 4,
                ),
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
            Text(description,
                maxLines: 2,
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
            if (index != null && index == 1) button!,
          ],
        ),
      ],
    );
  }
}
