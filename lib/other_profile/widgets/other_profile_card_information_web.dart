import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/others_profile_data.dart';
import 'position_other_profile_web.dart';

class OtherProfileCardInformationWeb extends StatefulWidget {
  final OtherProfileData loadProfile;
  OtherProfileCardInformationWeb({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);
  var moreOptions = false;

  @override
  State<OtherProfileCardInformationWeb> createState() =>
      _OtherProfileCardInformationWebState();
}

class _OtherProfileCardInformationWebState
    extends State<OtherProfileCardInformationWeb> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(right: 180, bottom: 25, top: 30),
      width: 60.w,
      height: widget.moreOptions ? 76.h : 58.h,
      color: Colors.white,
      child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            //Profile back ground
            Container(
              color: Colors.white,
              height: (widget.loadProfile.description == null ||
                      widget.loadProfile.description == '')
                  ? widget.moreOptions
                      ? 10.h
                      : 7.h
                  : (widget.moreOptions
                          ? 10.h
                          : 7.h +
                              ((widget.loadProfile.description)
                                      .toString()
                                      .length /
                                  42) +
                              4)
                      .h,
              width: 100.w,
              child: Image.network(
                widget.loadProfile.profileBackPicture.toString(),
                fit: BoxFit.cover,
              ),
            ),
            //tomake widget position
            PositionOtherProfileWeb(loadProfile: widget.loadProfile),
            // OptionsButton(
            // //  moreOptions: OtherProfileCardInformationWeb.moreOptions,
            //   ),
            Positioned(
                top: 340,
                child: Column(
                  children: [
                    Visibility(
                      visible: widget.moreOptions,
                      child: Container(
                          margin: EdgeInsets.only(left: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Send Message',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                              TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Block User',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                              TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Get Them Help and Support',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                              TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Report User',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ))
                            ],
                          )),
                    ),
                    Container(
                        width: 15.w,
                        height: 6.h,
                        margin: EdgeInsets.only(left: 100),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              widget.moreOptions = !widget.moreOptions;
                            });
                          },
                          style: ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all(Colors.blue)
                              ),
                          child: Text(
                            widget.moreOptions
                                ? 'More Options'
                                : 'Less Options',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )),
                  ],
                )),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(bottom: 30, top: 55, left: 10),
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.loadProfile.profilePicture.toString()),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
