import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../models/myprofile_data.dart';
import '../screens/edit_profile_screen.dart';
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
        color:Colors.white,
       // height: 50.h,
        padding: EdgeInsets.only(left: 10, top: 5),
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
            Text(
                'u/${loadProfile.displayName}',
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
                    Text('Karma',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        Icon(
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
              SizedBox(width: 7.w,),
                Column(
                  children: [
                    Text('CakeDay',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        Icon(
                          Icons.cake,
                          color: Colors.blue,
                        ),
                        Text('${
                          DateFormat.yMMMMd('en_US')
                          .format(DateTime.parse(loadProfile.createdAt.toString()))
                         // loadProfile.createdAt.toString()
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
                // alignment: Alignment.bottomLeft,
                //color: Colors.amber,
                // margin: EdgeInsets.all(30),
                height: 7.5.h,
                width: 40.w,
                child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(UserFollowersScreen.routeName),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      //  backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'followers',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.blue),
                              Text(
                                '${loadProfile.followersCount} ',
                                style: const TextStyle(
                                    //backgroundColor: Colors.orange,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.only(top: 4,right: 30,left: 10),
                    height: 5.h,
                    width: 20.w,
                    //color: Colors.yellow,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                      child: Text(
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
