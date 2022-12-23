import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:cached_network_image/cached_network_image.dart';

class NotificationImage extends StatelessWidget {
  const NotificationImage(
      {super.key,
      required this.usersAllNotificatiion,
      required this.userPhoto,
      required this.height,
      required this.width});

  final String usersAllNotificatiion;
  final String userPhoto;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      width: width * 0.1, //40,
      height: height * 0.1, //80,
      child: Stack(children: [
        Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Image.network(
                userPhoto,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/default-img.png',
                ),
              )),
        ),
        Positioned(
          bottom: (kIsWeb) ? 0.1.h : height * 0.018,
          right: (kIsWeb) ? 2.5.w : width * 0.005,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 11,
            child: CircleAvatar(
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
