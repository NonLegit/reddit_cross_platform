import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../icons/reddit_icons.dart';
import '../screens/signup.dart';
import '../screens/login.dart';
import '../../moderation_settings/widgets/status.dart';
import '../../screens/emptyscreen.dart';
import '../../home/screens/home_layout.dart';

class UpperBar extends StatelessWidget {
  /// the current status of the poassword input field if it origin or taped or error

  final UpperbarStatus currentStatus;
  const UpperBar(this.currentStatus, {super.key});

  ///replace the current screen with other on
  ///
  ///if the screen was login then pop it and go to sign up
  ///else if it was sign up pop the sign uo and go to login
  ///else if it was skiped then go to home page
  ///else go to no where
  void _pushScreen(context) {
    Navigator.of(context).pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ResponsiveSizer(
            builder: (cntx, orientation, Screentype) {
              // Device.deviceType == DeviceType.web;
              return Scaffold(
                body: currentStatus == UpperbarStatus.login
                    ? Login()
                    : currentStatus == UpperbarStatus.signup
                        ? SignUp()
                        : currentStatus == UpperbarStatus.skip
                            ? HomeLayoutScreen()
                            : EmptyScreen(),
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
                    child: currentStatus == UpperbarStatus.login
                        ? Text(
                            'Log in',
                            style: TextStyle(color: Colors.black54),
                          )
                        : currentStatus == UpperbarStatus.signup
                            ? Text('Sign up',
                                style: TextStyle(color: Colors.black54))
                            : currentStatus == UpperbarStatus.skip
                                ? Text('Skip',
                                    style: TextStyle(color: Colors.black54))
                                : Text('',
                                    style: TextStyle(color: Colors.black54)),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
