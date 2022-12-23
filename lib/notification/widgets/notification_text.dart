import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  NotificationText(
      {super.key,
      required this.description,
      required this.time,
      required this.text,
      required this.image,
      required this.width,
      this.button,
      this.index});
  String text;
  String time;
  String description;
  Widget image;
  Widget? button;
  int? index;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            image,
            SizedBox(
              width: width * 0.02,
            ),
            SizedBox(
              width: width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      text: TextSpan(
                          text: '$text   ',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                          children: [
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 4,
                              ),
                            ),
                            TextSpan(
                                text: time,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10))
                          ])

                      //overflow: TextOverflow.clip,
                      ),
                  const Divider(
                    height: 6,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Text(description,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  if (index != null && index == 1) button!,
                ],
              ),
            ),

            // const Icon(
            //   Icons.circle,
            //   color: Colors.grey,
            //   size: 4,
            // ),
            // SizedBox(
            //   width: width * 0.01,
            // ),
            // Text(
            //   time,
            //   style: const TextStyle(color: Colors.grey, fontSize: 10),
            // ),
          ],
        ),
      ],
    );
  }
}
