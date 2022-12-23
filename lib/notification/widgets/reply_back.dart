import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReplyBack extends StatelessWidget {
ReplyBack({
    super.key,
    this.commentId,
    this.postId
  });
  String? commentId;
  String? postId; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: SizedBox(
        width: (kIsWeb) ? 10.w : 75.w,
        height: 3.h,
        child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.reply,
                  size: 17,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  'Reply',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            )),
      ),
    );
  }
}
