import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/myprofile_data.dart';
import 'position_myprofile_web.dart';

class MyProfileCardInformationWeb extends StatelessWidget {
  final MyProfileData loadProfile;
  const MyProfileCardInformationWeb({
    required this.loadProfile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
        margin: EdgeInsets.only(right: 180, bottom: 25, top: 30),
        width: 50.w,
        height: (loadProfile.description == null ||
                loadProfile.description == '')
            ? 43.h
            : (43 + ((loadProfile.description).toString().length / 42) + 4).h,
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              //Profile back ground
              Container(
                height: (loadProfile.description == null ||
                        loadProfile.description == '')
                    ? 40.h
                    : (40 +
                            ((loadProfile.description).toString().length / 42) +
                            4)
                        .h,
                width: 100.w,
                child: Image.network(
                  loadProfile.profileBackPicture.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              //tomake widget position
              PositionMyProfileWeb(loadProfile: loadProfile),
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30, top: 40, left: 10),
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image:
                            NetworkImage(loadProfile.profilePicture.toString()),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
