import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../icons/redditIcons.dart';
import '../../icons/GoogleFacebookIcons.dart';
import '../../icons/closeIcons.dart';
import '../screens/signup.dart';
import '../screens/login.dart';

class UpperBar extends StatelessWidget {
  //  UpperBar({Key? key}) : super(key: key);
  final String openningScreen;
  UpperBar(this.openningScreen);
  void _pushScreen(context) {
    Navigator.of(context).pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ResponsiveSizer(
            builder: (cntx, orientation, Screentype) {
              // Device.deviceType == DeviceType.web;
              return Scaffold(
                body: openningScreen == 'log' ? Login() : SignUp(),
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: Adaptive.w(33),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
            ),
            Container(
                width: 33.w,
                child: Center(
                  child: Icon(
                      color: Theme.of(context).primaryColor,
                      RedditIcons.reddit),
                )),
            Container(
                width: 33.w,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    onPressed: () {
                      _pushScreen(context);
                    },
                    child: openningScreen == 'log'
                        ? Text(
                            'Log in',
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text('Sign up',
                            style: TextStyle(color: Colors.black54)),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
