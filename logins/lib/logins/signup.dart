import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import '../icons/redditIcons.dart';
import '../icons/GoogleFacebookIcons.dart';
import 'login.dart';
import '../icons/closeIcons.dart';

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final inputEmailController = TextEditingController();
  final inputUserNameController = TextEditingController();
  final inputPasswardController = TextEditingController();
  bool isFinished = false;
  bool isVisable = false;
  void _pushLogIn() {
    Navigator.of(context).pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ResponsiveSizer(
            builder: (cntx, orientation, Screentype) {
              Device.deviceType == DeviceType.web;
              return Scaffold(
                // appBar: AppBar(
                //   title: Text('Saved Suggestions'),
                // ),
                body: Login(),
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isFinished = false;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaQuery.padding.top,
          ),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Colors.blue)
                        ))),
                        onPressed: _pushLogIn,
                        child: Text(
                            style: TextStyle(color: Colors.black54), 'Log in')),
                  )),
            ],
          ),
          Expanded(
            child: Container(
              // height: 80.h,
              child: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        'Hi new friend, welcome to Reddit'),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                                color: Colors.blue, GoogleFacebookIcons.google),
                            Text(
                                style: TextStyle(color: Colors.blue),
                                'Continue with Google'),
                            SizedBox(
                              width: 1,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                                color: Colors.blue,
                                GoogleFacebookIcons.facebook),
                            Text(
                                style: TextStyle(color: Colors.blue),
                                'Continue with Face Book'),
                            SizedBox(
                              width: 1,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 20.h,
                          child: Divider(
                            // height: 2,
                            thickness: 1,
                            color: Colors.black26,
                          ),
                        ),
                        Container(
                          child:
                              Text(style: TextStyle(color: Colors.black), 'OR'),
                        ),
                        Container(
                          width: 20.h,
                          child: Divider(
                            thickness: 1,
                            color: Colors.black26,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color.fromARGB(255, 203, 203, 203),
                      child: TextField(
                        controller: inputEmailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          )),
                          suffixIcon: IconButton(
                              onPressed: () {
                                inputEmailController.clear();
                              },
                              color: Colors.black45,
                              icon: Icon(CloseIcons.cancel_circled2)),
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Email'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color.fromARGB(255, 203, 203, 203),
                      child: TextField(
                        controller: inputUserNameController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          )),
                          suffixIcon: IconButton(
                              onPressed: () {
                                inputUserNameController.clear();
                              },
                              color: Colors.black45,
                              icon: Icon(CloseIcons.cancel_circled2)),
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Username'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color.fromARGB(255, 203, 203, 203),
                      child: TextField(
                        controller: inputPasswardController,
                        obscureText: !isVisable,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          )),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              color: Colors.black45,
                              icon: Icon(isVisable
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined)),
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('passward'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'User Agreement ',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            //on tap code here, you can navigate to other page or URL
                            String url =
                                "https://www.redditinc.com/policies/user-agreement";
                            var urllaunchable = await canLaunch(
                                url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(
                                  url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                      ),
                      TextSpan(
                          style: TextStyle(color: Colors.black), text: 'and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            //on tap code here, you can navigate to other page or URL
                            String url =
                                "https://www.reddit.com/policies/privacy-policy";
                            var urllaunchable = await canLaunch(
                                url); //canLaunch is from url_launcher package
                            if (urllaunchable) {
                              await launch(
                                  url); //launch is from url_launcher package to launch URL
                            } else {
                              print("URL can't be launched.");
                            }
                          },
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          // Spacer(),
          Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: isFinished ? () {} : null,
                  child: Text('Continue'),
                ),
              ))
        ],
      ),
    );
  }
}
