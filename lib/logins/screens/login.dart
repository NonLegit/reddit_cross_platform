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

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  /// listener to the Username input field
  final inputUserNameController = TextEditingController();

  /// listener to the password input field
  final inputPasswardController = TextEditingController();

  /// Whether the user finish enter the 3 inputs
  bool isFinished = false;

  ///Whether the password is visiable or not
  BoolWrapper isVisable = BoolWrapper();

  ///controlling the finish flag
  ///
  ///when user typing in any input field ->
  ///check the changes and detect when the finish flag is true
  ///and then activate the continue bottom
  void changeInput() {
    isFinished = (!inputUserNameController.text.isEmpty) &
        (!inputPasswardController.text.isEmpty);
  }

  /// Whether there is an error in the fields or not
  bool isError = false;

  /// Whether the user tring to submit or not
  bool isSubmit = false;

  ///saving the authontigation from the back
  String token = '';
  String expiresIn = '';

  /// error message to view when the log in is failed
  String errorMessage = '';

  /// variable to contain the url of the server
  final String url =
      'https://abf8b3a8-af00-46a9-ba71-d2c4eac785ce.mock.pstmn.io';

  /// variable to check if the backend finish the actual server of work with the mock
  final bool isMock = true;

  ///post the login info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  /// if the server return failed response then there is error message will appare
  /// other wise jump on the homeScreen
  void checkLogin() {
    Uri URL = Uri.parse(url + '/users/login' + ((isMock) ? '/1' : ''));
    http
        .post(URL,
            body: json.encode({
              'userName': inputUserNameController.text,
              'password': inputPasswardController.text
            }))
        .then((response) {
      if (response.statusCode == 200) {
        isError = false;
        token = json.decode(response.body)['token'];
        expiresIn = json.decode(response.body)['expiresIn'];
        Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
      } else if (response.statusCode == 400) {
        isError = true;
        errorMessage = json.decode(response.body)['errorMessage'];
      } else if (response.statusCode == 404) {
        isError = true;
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      isSubmit = true;
      setState(() {});
    });
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
                      changeInput: () {
                        setState(() {
                          changeInput();
                        });
                      },
                      inputController: inputUserNameController),
                  PasswordInput(
                      isVisable: isVisable,
                      lable: 'Password',
                      ontap: (hasfocus) {},
                      changeInput: () {
                        setState(() {
                          changeInput();
                        });
                      },
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