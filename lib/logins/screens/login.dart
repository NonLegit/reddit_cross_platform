import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../widgets/upper_bar.dart';
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

import '../../home/screens/home_layout.dart';
import '../models/status.dart';

class Login extends StatefulWidget {
  // Login({Key? key}) : super(key: key);
  static const routeName = '/Login';

  /// variable to contain the url of the server
  final String url =
      'https://abf8b3a8-af00-46a9-ba71-d2c4eac785ce.mock.pstmn.io';

  /// variable to check if the backend finish the actual server of work with the mock
  final bool isMock = true;
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
  bool isSubmit = false;
  String token = '';
  String expiresIn = '';
  String errorMessage = '';
  void checkLogin() {
    // print('the user name is: ' + inputUserNameController.text);
    // print('the password is: ' + inputPasswardController.text);
    Uri URL =
        Uri.parse(widget.url + '/users/login' + ((widget.isMock) ? '/1' : ''));
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
        Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
      } else if (response.statusCode == 400) {
        // print('bad request');
        isError = true;
        errorMessage = json.decode(response.body)['errorMessage'];
      } else if (response.statusCode == 404) {
        // print('incorrect userName or password');
        isError = true;
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      isSubmit = true;
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
          UpperBar(UpperbarStatus.signup),
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
                      ontap: (hasfocus) {},
                      changeInput: changeInput,
                      inputController: inputUserNameController),
                  PasswordInput(
                      isVisable: isVisable,
                      lable: 'Password',
                      ontap: (hasfocus) {},
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
                          child: Text(
                              style: TextStyle(color: Colors.red),
                              'Forget passward'))),
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
          if (isSubmit && isError)
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Center(
                child: Text(
                    textAlign: TextAlign.center,
                    errorMessage,
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w500,
                      color: Theme.of(context).errorColor,
                    )),
              ),
            ),
          if (isSubmit && !isError)
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Text(
                  textAlign: TextAlign.center,
                  'you will receve if that adress maches your mail',
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w500,
                    color: Colors.green,
                  )),
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
                    onPrimary: Colors.white,
                    primary: Colors.red,
                    onSurface: Colors.grey[700],
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
