import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../models/others_profile_data.dart';
import '../../widgets/custom_snack_bar.dart';
import '../screens/others_profile_screen.dart';
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
      margin: const EdgeInsets.only(right: 180, bottom: 25, top: 30),
     width: 50.w,
      height: widget.moreOptions ? 80.h : 70.h,
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
                      ? 60.h
                      : 50.h
                  : (widget.moreOptions
                          ? 60.h
                          : 50.h +
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
              Positioned(
                top: 340,
                child: Column(
                  children: [
                    Visibility(
                      visible: widget.moreOptions,
                      child: Container(
                          margin: const EdgeInsets.only(left: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              const TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Send Message',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                              TextButton(
                                  onPressed: ()=> _showBlockDialog(),
                                  child: const Text(
                                    'Block User',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            ],
                          )),
                    ),
                    Container(
                        width: 15.w,
                        height: 6.h,
                        margin: const EdgeInsets.only(left: 100),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              widget.moreOptions = !widget.moreOptions;
                            });
                          },
                          style: const ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all(Colors.blue)
                              ),
                          child: Text(
                            widget.moreOptions
                                ? 'Less Options'
                                : 'More Options',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )),
                  ],
                )),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30, top: 55, left: 10),
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
  // ===================================the next three function used to===========================================//
//==================Block user===========================//
// have two option one:blocksubreddit two: cancel
  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        //title:Text('Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        content: Container(
          //color: Colors.amber,
          height: 12.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block u/${widget.loadProfile.userName}?',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'They won\'t be able to contact you or view your profile, posts, or comments.',
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 236, 235, 235)),
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ),
          Container(
            width: 15.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 242, 16, 0)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Block account'),
              onPressed: () async {
                Navigator.popUntil(context,
                    ModalRoute.withName(OthersProfileScreen.routeName));
                bool block = await Provider.of<OtherProfileprovider>(context,
                        listen: false)
                    .blockUser(widget.loadProfile.userName.toString(), context);
                if (!block) {
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                      isError: false,
                      text: 'Block Successfully',
                      disableStatus: true));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(
                        isError: false,
                        text: 'Block Failed',
                        disableStatus: true),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
