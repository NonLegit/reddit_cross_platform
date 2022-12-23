import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/myprofile_data.dart';
import '../screens/user_followers_screen.dart';

class PositionMyProfileWeb extends StatelessWidget {
  const PositionMyProfileWeb({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);

  final MyProfileData loadProfile;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      height: 100.h,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),

            //username
            Text(
              loadProfile.displayName.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            //name and discibtions
            Text('u/${loadProfile.displayName}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 13)),
            Container(
              width: 100.w,
              height: (loadProfile.description == null ||
                      loadProfile.description == '')
                  ? 0.h
                  : (0 + (loadProfile.description.toString().length / 42) + 4)
                      .h,
              child: Text(loadProfile.description.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 13)),
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Text('Karma',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        Text(
                            '${int.parse(loadProfile.postKarma.toString()) + int.parse(loadProfile.commentkarma.toString())}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 7.w,
                ),
                Column(
                  children: [
                    const Text('CakeDay',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        const Icon(
                          Icons.cake,
                          color: Colors.blue,
                        ),
                        Text(
                            '${DateFormat.yMMMMd('en_US').format(DateTime.parse(loadProfile.createdAt.toString()))
                            }',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            //followers
            Container(
                padding: const EdgeInsets.all(0),
                height: 7.5.h,
                width: 40.w,
                child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(UserFollowersScreen.routeName),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'followers',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blue),
                              Text(
                                '${loadProfile.followersCount} ',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13),
                                textAlign: TextAlign.justify,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ],
                          )
                        ]))),

            Container(
              padding: const EdgeInsets.only(top: 4, right: 30, left: 10),
              height: 5.h,
              width: 20.w,
              //color: Colors.yellow,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)))),
                ),
                child: const Text(
                  'New Post',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
