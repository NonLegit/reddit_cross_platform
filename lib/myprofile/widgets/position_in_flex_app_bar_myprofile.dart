import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/myprofile_data.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/user_followers_screen.dart';

class PositionInFlexAppBarMyProfile extends StatelessWidget {
  const PositionInFlexAppBarMyProfile({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);

  final MyProfileData loadProfile;

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
            Container(
              child: CircleAvatar(
                radius: 43,
                backgroundImage:
                    NetworkImage(loadProfile.profilePicture.toString()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Edit
            Container(
                width: 23.w,
                height: 6.h,
                //Edit Button used to Edit User information
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditProfileScreen.routeName),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.white)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(137, 33, 33, 33)),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              loadProfile.displayName.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Container(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.bottomLeft,
                height: 4.5.h,
                width: 40.w,
                child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(UserFollowersScreen.routeName),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${loadProfile.followersCount} followers',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            textAlign: TextAlign.justify,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          )
                        ]))),
            //name and discibtions
            Text(
                'u/${loadProfile.displayName} .${int.parse(loadProfile.postKarma.toString()) + int.parse(loadProfile.commentkarma.toString())}.${DateFormat.yMMMMd('en_US').format(DateTime.parse(loadProfile.createdAt.toString()))}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 13)),
            const SizedBox(
              height: 7,
            ),
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
