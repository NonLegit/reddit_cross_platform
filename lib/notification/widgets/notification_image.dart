import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NotificationImage extends StatelessWidget {
  const NotificationImage({
    super.key,
    required this.usersAllNotificatiion,
  });

  final String usersAllNotificatiion;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      width: 40,
      height: 80,
      child: Stack(children: [
        const Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/img.jpg'),
            radius: 17,
          ),
        ),
        Positioned(
          bottom: (kIsWeb) ? 2.h : 1.8.h,
          right: (kIsWeb) ? 0.3.w : 0.5.w,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 11,
            child: CircleAvatar(
              //minRadius: 2,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(usersAllNotificatiion),
              radius: 7,
            ),
          ),
        ),
      ]),
    );
  }
}
