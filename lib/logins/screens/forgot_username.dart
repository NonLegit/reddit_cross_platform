import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../widgets/upper_bar.dart';
import '../widgets/upper_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';
import '../../moderation_settings/widgets/status.dart';
import '../providers/authentication.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'signup.dart';
import 'login.dart';
import '../widgets/web_image.dart';

class ForgotUserName extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/ForgotUserName';

  const ForgotUserName({super.key});
  @override
  State<ForgotUserName> createState() => ForgotUserNameState();
}

class ForgotUserNameState extends State<ForgotUserName> {
  /// Whether there is an error in the fields or not
  bool isError = false;

  /// Whether the user tring to submit or not
  bool isSubmit = false;

  /// error message to view when the log in is failed
  String errorMessage = '';

  /// Whether the user finish enter the 3 inputs
  bool isFinished = false;

  /// listener to the Email input field
  TextEditingController inputEmailController = TextEditingController();

  ///controlling the finish flag
  ///
  ///when user typing in any input field ->
  ///check the changes and detect when the finish flag is true
  ///and then activate the continue bottom
  void changeInput() {
    isFinished = (!inputEmailController.text.isEmpty) &&
        (validateEmail() == InputStatus.sucess);
  }

  /// the Current Status of the Email input field
  InputStatus inputEmailStatus = InputStatus.original;

  /// error message to view when the Email is invalid
  String emailErrorMessage = '';

  /// Returns the Status of the Email input field after check its validation
  ///
  /// the validation will be sucess when :
  ///      1- the email is correct
  /// the validator will return original if the field is empty
  /// otherwise the status will be faild and put an error message
  InputStatus validateEmail() {
    //Input : none
    //output: return the status of the Email input field

    if (inputEmailController.text.isEmpty) {
      return InputStatus.original;
    } else if (EmailValidator.validate(
        inputEmailController.text.toLowerCase())) {
      return InputStatus.sucess;
    } else {
      emailErrorMessage = 'Not a valid email address';
      return InputStatus.failed;
    }
  }

  /// Control the status of the Email textfield
  ///
  /// when user tap in the email textfailed mark it as taped
  /// when tap out check the validation using [validateEmail()]
  void controlEmailStatus(hasFocus) {
    //Input :
    //  hasFocuns : Whether the Email input field is clicked or not
    //output: none

    if (hasFocus)
      inputEmailStatus = InputStatus.taped;
    else
      inputEmailStatus = validateEmail();
  }

  ///post the forgotUsername  info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  /// if the server return failed response then there is error message will appare
  /// other show sucess message
  void submitForgorUserName() async {
    //Input : none
    //output: none

    final provider = Provider.of<Auth>(context, listen: false);
    await provider.forgetUserName({
      "email": inputEmailController.text,
    });
    setState(() {
      isSubmit = true;
      isError = provider.error;
      errorMessage = provider.errorMessage;
      if (isError == false) Navigator.of(context).pushNamed(Login.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kIsWeb) WebImageLoging(),
            SizedBox(
              width: (kIsWeb) ? 25.w : null,
              child: Column(
                mainAxisAlignment: (kIsWeb)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: (kIsWeb)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (!kIsWeb) UpperBar(UpperbarStatus.login),
                  Expanded(
                      flex: (kIsWeb) ? 0 : 1,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (kIsWeb)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/reddit.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              UpperText('Recover username'),
                              if (kIsWeb)
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      'Tell us the email address associated with your Reddit account, and we’ll send you an email with your username.'),
                                ),
                              TextInput(
                                  lable: 'Email',
                                  ontap: (hasFocus) {
                                    setState(() {
                                      controlEmailStatus(hasFocus);
                                    });
                                  },
                                  currentStatus: inputEmailStatus,
                                  changeInput: () {
                                    setState(() {
                                      changeInput();
                                    });
                                  },
                                  inputController: inputEmailController),
                              SizedBox(height: 2.h),
                              if (!kIsWeb)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      style: TextStyle(color: Colors.black54),
                                      'Unfortunately, if you have never given us your email, we will not able to reset your password'),
                                ),
                              if (!kIsWeb)
                                SizedBox(
                                  height: 4.h,
                                ),
                              if (!kIsWeb)
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Having trouble? ',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            //on tap code here, you can navigate to other page or URL
                                            String url =
                                                "https://www.reddithelp.com/hc/en-us/articles/205240005";
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
                                    ))
                            ]),
                      )),
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
                      height: (kIsWeb) ? 40 : null,
                      width: (kIsWeb) ? 200 : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: (kIsWeb) ? Colors.blue : Colors.red,
                            onSurface: Colors.grey[700],
                            shape: (kIsWeb)
                                ? null
                                : RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: isFinished ? submitForgorUserName : null,
                          child: (kIsWeb) ? Text('Email me') : Text('Continue'),
                        ),
                      )),
                  if (kIsWeb)
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Don\'t have an email or need assistance logging in?',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Get help',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    //on tap code here, you can navigate to other page or URL
                                    String url =
                                        "https://reddithelp.com/hc/en-us/sections/360008917491-Account-Security";
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
                            ],
                          ),
                        )),
                  if (kIsWeb)
                    Row(
                      children: [
                        TextButton(
                          child: Text(
                            'Log in',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Login.routeName);
                          },
                        ),
                        Text(' • '),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUp.routeName);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
