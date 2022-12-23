import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/others_profile_data.dart';
import '../widgets/invite_button.dart';
import '../../widgets/follow_button.dart';

class PositionInFlexAppBarOtherProfile extends StatelessWidget {
  PositionInFlexAppBarOtherProfile({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);

  OtherProfileData loadProfile;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 9.h,
      right: 5.w,
      width: 95.w,
      height: 100.h,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            //profile image
            CircleAvatar(
              radius: 45,
              backgroundImage:
                  NetworkImage(loadProfile.profilePicture.toString()),
            ),
            const SizedBox(
              height: 20,
            ),
            //Follow and invite
            Row(
              children: [
                FollowButton(
                    profileUsed: 'OtherProfile',
                    userName: loadProfile.userName.toString(),
                    isFollowed: loadProfile.isFollowed),
                Container(
                    width: 15.w,
                    height: 6.h,
                    child: InviteButton(
                        userName: loadProfile.userName.toString())),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //username
            Text(
              loadProfile.displayName.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            // //name and discibtions
            Text(
                'u/${loadProfile.displayName} .${int.parse(loadProfile.postKarma.toString()) + int.parse(loadProfile.commentkarma.toString())}.${DateFormat.yMMMMd('en_US').format(DateTime.parse(loadProfile.createdAt.toString()))}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 13)),
            const SizedBox(
              height: 7,
            ),
            //name and discibtions

            Container(
              width: 100.w,
              height: (loadProfile.description == null ||
                      loadProfile.description == '')
                  ? 0.h
                  : (0 + (loadProfile.description.toString().length / 42) + 7)
                      .h,
              child: Text(loadProfile.description.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
