import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/others_profile_data.dart';
import '../widgets/invite_button.dart';
class PositionInFlexAppBarOtherProfile extends StatelessWidget {
  const PositionInFlexAppBarOtherProfile({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);

  final OtherProfileData loadProfile;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      right: 10,
      width: 95.w,
      height: 100.h,
      child: Container(
        // alignment: Alignment.topLeft,
        //color: Colors.blue,
        padding: const EdgeInsets.all(20),
        //color: Colors.black54,
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
                Container(
                    width: loadProfile.isFollowed?30.w:23.w,
                    height: 6.h,
                    child: OutlinedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          //shape: Outlin,

                          side: MaterialStateProperty.all(
                              const BorderSide(
                                  color: Colors.white)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              30)))),
                          backgroundColor:
                              MaterialStateProperty.all(
                                  const Color.fromARGB(
                                      137, 33, 33, 33)),
                          foregroundColor:
                              MaterialStateProperty.all(
                                  Colors.white)),
                      child:  Text(
                        loadProfile.isFollowed?'Following':'Follow',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )),
                Container(
                    width: 15.w,
                    height: 6.h,
                    child: InviteButton()),
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
            //followers
            Container(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.bottomLeft,
              height: 4.5.h,
              width: 40.w,
              //  color: Colors.black,
              child: TextButton(
                onPressed: null,
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(
                            Colors.white)),
                child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${loadProfile.followersCount} followers',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                        textAlign: TextAlign.end,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      )
                    ]),
              ),
            ),
            //name and discibtions
           Text(
               'u/${loadProfile.displayName} . ${loadProfile.numOfDaysInReddit} .${int.parse(loadProfile.postKarma.toString()) + int.parse(loadProfile.commentkarma.toString())}.${loadProfile.createdAt.toString()}',
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
              height: (loadProfile.description==null||loadProfile.description == '')
                  ? 0.h
                  : (0 + (loadProfile.description.toString().length / 42) + 7).h,
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
