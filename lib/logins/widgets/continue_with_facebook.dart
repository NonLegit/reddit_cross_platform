import '../../icons/GoogleFacebookIcons.dart';
import 'package:flutter/material.dart';

class ContinueWithFacebook extends StatelessWidget {
  // const ContinueWithFacebook({Key? key}) : super(key: key);
  final VoidCallback handler;
  ContinueWithFacebook({required this.handler});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          onPressed: handler,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(color: Colors.blue, GoogleFacebookIcons.facebook),
              Text(
                  style: TextStyle(color: Colors.blue),
                  'Continue with Face Book'),
              SizedBox(
                width: 1,
              )
            ],
          )),
    );
  }
}
