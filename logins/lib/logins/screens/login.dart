import 'package:flutter/material.dart';
import 'package:logins/logins/widgets/text_input.dart';
import 'package:logins/logins/widgets/upper_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../icons/redditIcons.dart';
import '../../icons/GoogleFacebookIcons.dart';
import '../../icons/closeIcons.dart';
import 'signup.dart';
import '../widgets/upper_text.dart';
import 'forgot_password.dart';
import '../widgets/password_input.dart';
import '../widgets/continue_with_email.dart';
import '../widgets/continue_with_facebook.dart';
import '../widgets/continue_with_google.dart';
import 'package:http/http.dart' as http;
import '../models/wrapper.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  // Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final inputUserNameController = TextEditingController();
  final inputPasswardController = TextEditingController();
  bool isFinished = false;

  BoolWrapper isVisable = BoolWrapper();
  void changeInput() {
    setState(() {
      isFinished = (!inputUserNameController.text.isEmpty) &
          (!inputPasswardController.text.isEmpty);
    });
  }

  bool isError = false;
  String token = '';
  String expiresIn = '';

  /// variable to contain the url of the server
  final String url =
      'https://abf8b3a8-af00-46a9-ba71-d2c4eac785ce.mock.pstmn.io';

  /// variable to check if the backend finish the actual server of work with the mock
  final bool isMock = true;
  void checkLogin() {
    // print('the user name is: ' + inputUserNameController.text);
    // print('the password is: ' + inputPasswardController.text);
    Uri URL = Uri.parse(url + '/users/login' + ((isMock) ? '/1' : ''));
    http
        .post(URL,
            body: json.encode({
              'userName': inputUserNameController.text,
              'password': inputPasswardController.text
            }))
        .then((response) {
      // print('inside post' + response.statusCode.toString());
      if (response.statusCode == 200) {
        // print('sucess');
        isError = false;
        token = json.decode(response.body)['token'];
        expiresIn = json.decode(response.body)['expiresIn'];
      } else if (response.statusCode == 400) {
        // print('bad request');
        isError = true;
      } else if (response.statusCode == 404) {
        // print('incorrect userName or password');
        isError = true;
      }
      setState(() {});
    });
    // print('finish post');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpperBar('sign'),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  UpperText('Log in to Reddit'),
                  SizedBox(
                    height: 4.h,
                  ),
                  ContinueWithGoogle(handler: () {}),
                  ContinueWithFacebook(handler: () {}),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 20.h,
                          child: Divider(
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
                  TextInput(
                      lable: 'Username',
                      ontap: () {},
                      changeInput: changeInput,
                      inputController: inputUserNameController),
                  PasswordInput(
                      isVisable: isVisable,
                      lable: 'Password',
                      ontap: () {},
                      changeInput: changeInput,
                      inputController: inputPasswardController),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResponsiveSizer(
                                    builder: (cntx, orientation, Screentype) {
                                      // Device.deviceType == DeviceType.web;
                                      return Scaffold(body: ForgotPassword());
                                    },
                                  ),
                                ));
                          },
                          child: Text('Forget passward'))),
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
          if (isError)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text('incorrect username of password',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w500,
                      color: Theme.of(context).errorColor,
                    )),
              ),
            ),
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
                  onPressed: isFinished ? checkLogin : null,
                  child: Text('Continue'),
                ),
              )),
        ],
      ),
    );
  }
}
