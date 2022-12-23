import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

class HyperLinkText extends StatelessWidget {
  ///the basic lable of the input text field
  final String label;

  /// the url that will be lanched when click in the URl text
  final String url;
  const HyperLinkText({super.key, required this.label, required this.url});
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
