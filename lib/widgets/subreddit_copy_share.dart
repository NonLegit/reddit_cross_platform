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
        color: Color.fromARGB(255, 216, 215, 215),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BarWidget(),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
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
                  Icon(
                    Icons.document_scanner,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    link,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: link));
                      },
                      child: Text("Copy")),
                ],
              ),
            ),
          ]),
    );
  }
}
