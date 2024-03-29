import '../../icons/google_facebook_icons.dart';
import 'package:flutter/material.dart';

class ContinueWithGoogle extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);
  final VoidCallback handler;
  ContinueWithGoogle({required this.handler});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(color: Color.fromARGB(255, 56, 93, 164)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          onPressed: handler,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(color: Colors.black, GoogleFacebookIcons.google),
              Text(
                  style: TextStyle(color: Color.fromARGB(255, 56, 93, 164)),
                  'Continue with Google'),
              SizedBox(
                width: 1,
              )
            ],
          )),
    );
  }
}
