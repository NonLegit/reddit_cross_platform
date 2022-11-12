import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

class HyperLinkText extends StatelessWidget {
  // const HyperLinkText({Key? key}) : super(key: key);
  final String label;
  final String url;
  HyperLinkText({required this.label, required this.url});
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'User Agreement ',
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColor),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          //on tap code here, you can navigate to other page or URL
          String url = "https://www.redditinc.com/policies/user-agreement";
          var urllaunchable =
              await canLaunch(url); //canLaunch is from url_launcher package
          if (urllaunchable) {
            await launch(
                url); //launch is from url_launcher package to launch URL
          } else {
            print("URL can't be launched.");
          }
        },
    ));
  }
}
