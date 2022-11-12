import 'package:flutter/material.dart';
import '../../icons/GoogleFacebookIcons.dart';

class ContinueWithEmail extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);
  final VoidCallback handler;

  ContinueWithEmail({required this.handler});
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
              Icon(color: Colors.black, Icons.email),
              Text(style: TextStyle(color: Colors.blue), 'Continue with email'),
              SizedBox(
                width: 1,
              )
            ],
          )),
    );
  }
}
