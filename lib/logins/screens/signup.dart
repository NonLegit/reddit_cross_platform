import 'package:flutter/material.dart';
import '../widgets/upper_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../icons/redditIcons.dart';
import '../../icons/GoogleFacebookIcons.dart';
import 'login.dart';
import '../../icons/closeIcons.dart';
import '../widgets/upper_text.dart';

import '../widgets/text_input.dart';
import '../widgets/password_input.dart';

import '../widgets/continue_with_facebook.dart';
import '../widgets/continue_with_google.dart';
import '../models/wrapper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/status.dart';
import 'package:email_validator/email_validator.dart';
import 'gender.dart';

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);
  static const routeName = '/SignUp';
  String token = '';
  String expiresIn = '';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isFinished = false;
  bool isUnige = false;
  BoolWrapper isVisable = BoolWrapper();

  final inputEmailController = TextEditingController();
  final inputUserNameController = TextEditingController();
  final inputPasswardController = TextEditingController();

  InputStatus inputEmailStatus = InputStatus.original;
  InputStatus inputUsernameStatus = InputStatus.original;
  InputStatus inputPasswardStatus = InputStatus.original;

  String emailErrorMessage = '';
  String usernameErrorMessage = '';
  String passwordErrorMessage = '';
  // check if the user enter the input field correctly
  // and then activate the continue bottom
  void changeInput() {
    isFinished = (validateEmail() == InputStatus.sucess) &
        (validateUsername() == InputStatus.sucess) &
        (validatePassword() == InputStatus.sucess);
  }

  InputStatus validateEmail() {
    // print(EmailValidator.validate(inputEmailController.text.toLowerCase()));
    if (inputEmailController.text.isEmpty)
      return InputStatus.original;
    else if (EmailValidator.validate(inputEmailController.text.toLowerCase()))
      return InputStatus.sucess;
    else {
      emailErrorMessage = 'Not a valid email address';
      return InputStatus.failed;
    }
  }

  Future checkUnique() async {
    Uri URL = Uri.parse(url +
        '/users/username_available' +
        ((isMock) ? '/3' : '') +
        '?userName=${inputUserNameController.text}');

    await http.get(URL).then((response) {
      isUnige = jsonDecode(response.body)['available'];
      // if (jsonDecode(response.body)['available'] == true)
      //   isUnige = true;
      // else
      //   isUnige = false;
    });
  }

  InputStatus validateUsername() {
    if (inputUserNameController.text.isEmpty) {
      return InputStatus.original;
    } else if (inputUserNameController.text.length < 3 ||
        inputUserNameController.text.length > 20) {
      usernameErrorMessage = 'Username must be between 3 and 20 characters';
      return InputStatus.failed;
    } else {
      checkUnique();
      if (isUnige)
        return InputStatus.sucess;
      else {
        usernameErrorMessage = 'that username is already taken';
        return InputStatus.failed;
      }
    }
  }

  InputStatus validatePassword() {
    if (inputPasswardController.text.isEmpty)
      return InputStatus.original;
    else if (inputPasswardController.text.length >= 8)
      return InputStatus.sucess;
    else {
      passwordErrorMessage = 'the password must be at least 8 characters';
      return InputStatus.failed;
    }
  }

  void controlEmailStatus(hasFocus) {
    if (hasFocus == true)
      inputEmailStatus = InputStatus.taped;
    else
      inputEmailStatus = validateEmail();
  }

  void controlUsernameStatus(hasFocus) {
    if (hasFocus)
      inputUsernameStatus = InputStatus.taped;
    else
      inputUsernameStatus = validateUsername();
  }

  void controlPasswordStatus(hasFocus) {
    if (hasFocus)
      inputPasswardStatus = InputStatus.taped;
    else
      inputPasswardStatus = validatePassword();
  }

  /// variable to contain the url of the server
  final String url =
      'https://abf8b3a8-af00-46a9-ba71-d2c4eac785ce.mock.pstmn.io';

  /// variable to check if the backend finish the actual server of work with the mock
  final bool isMock = true;

  void submitSignUp() {
    Uri URL = Uri.parse(url + '/users/signup' + ((isMock) ? '/1' : ''));
    print(URL.toString());
    http
        .post(URL,
            body: json.encode({
              'userName': inputUserNameController.text,
              'email': inputEmailController.text,
              'password': inputPasswardController.text
            }))
        .then((response) {
      print('the status code: ' + response.statusCode.toString());
      if (response.statusCode == 201) {
        widget.token = json.decode(response.body)['token'];
        widget.expiresIn = json.decode(response.body)['expiresIn'];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ResponsiveSizer(
                builder: (cntx, orientation, Screentype) {
                  // Device.deviceType == DeviceType.web;
                  return Gender();
                },
              ),
            ));
      }
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
          UpperBar(UpperbarStatus.login),
          Expanded(
            child: Container(
              // height: 80.h,
              child: SingleChildScrollView(
                child: Column(children: [
                  UpperText('Hi new friend, welcome to Reddit'),
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
                  TextInput(
                      currentStatus: inputEmailStatus,
                      lable: 'Email',
                      ontap: (focus) {
                        controlEmailStatus(focus);
                        setState(() {});
                      },
                      changeInput: changeInput,
                      inputController: inputEmailController),
                  if (inputEmailStatus == InputStatus.failed)
                    Text(
                      emailErrorMessage,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  TextInput(
                      currentStatus: inputUsernameStatus,
                      lable: 'Username',
                      ontap: (focus) {
                        controlUsernameStatus(focus);
                        setState(() {});
                      },
                      changeInput: changeInput,
                      inputController: inputUserNameController),
                  if (inputUsernameStatus == InputStatus.failed)
                    Text(
                      usernameErrorMessage,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  PasswordInput(
                      lable: 'Passward',
                      currentStatus: inputPasswardStatus,
                      ontap: (focus) {
                        controlPasswordStatus(focus);
                        setState(() {});
                      },
                      isVisable: isVisable,
                      changeInput: () {
                        setState(() {
                          changeInput();
                        });
                      },
                      inputController: inputPasswardController),
                  if (inputPasswardStatus == InputStatus.failed)
                    Text(
                      passwordErrorMessage,
                      style: TextStyle(color: Theme.of(context).errorColor),
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
                  onPressed: isFinished ? submitSignUp : null,
                  child: Text('Continue'),
                ),
              ))
        ],
      ),
    );
  }
}
