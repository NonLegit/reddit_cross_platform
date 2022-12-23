import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'barwidget.dart';

class CopyShare extends StatelessWidget {
  final String link;
  const CopyShare({
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 22.h,
      width: 100.w,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 215, 215),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const BarWidget(),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100.w,
              height: 16.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.document_scanner,
                    color: Colors.blue,
                  ),
                  Text(
                    link,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: link));
                      },
                      child: const Text(
                        "Copy",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ),
          ]),
    );
  }
}
