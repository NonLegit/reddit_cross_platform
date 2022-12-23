import 'package:flutter/material.dart';
import '../widgets/upper_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/upper_text.dart';
import '../widgets/text_input.dart';
import '../widgets/password_input.dart';
import '../widgets/continue_with_facebook.dart';
import '../widgets/continue_with_google.dart';
import '../../models/wrapper.dart';
import '../../moderation_settings/widgets/status.dart';
import 'package:email_validator/email_validator.dart';
import 'gender.dart';
import '../providers/authentication.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'login.dart';
import '../widgets/web_image.dart';

// (kIsWeb) ? Colors.blue : Colors.red
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  /// the route name of the screen

  static const routeName = '/SignUp';
  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  /// Whether there is an error in the fields or not
  bool isError = true;

  /// Whether the user tring to submit or not
  bool isSubmit = false;

  /// error message to view when the log in is failed
  String errorMessage = '';

  /// Whether the user finish enter the 3 inputs
  bool isFinished = false;

  /// Whether the user name is unige
  bool isUnige = false;

  ///Whether the password is visiable or not
  BoolWrapper isVisable = BoolWrapper();

  /// listener to the Email input field
  final inputEmailController = TextEditingController();

  /// listener to the Username input field
  final inputUserNameController = TextEditingController();

  /// listener to the password input field
  final inputPasswardController = TextEditingController();

  /// the Current Status of the Email input field
  InputStatus inputEmailStatus = InputStatus.original;

  /// the Current Status of the Email input field
  InputStatus inputUsernameStatus = InputStatus.original;

  /// the Current Status of the Email input field
  InputStatus inputPasswardStatus = InputStatus.original;

  /// error message to view when the Email is invalid
  String emailErrorMessage = '';

  /// error message to view when the username is invalid
  String usernameErrorMessage = '';

  /// error message to view when the password is invalid
  String passwordErrorMessage = '';

  ///controlling the isfinish flag
  ///
  ///when user typing in any input field ->
  ///check the changes and detect when the finish flag is true
  ///and then activate the continue bottom
  void changeInput() {
    //Input : none
    //output: none

    isFinished = (validateEmail() == InputStatus.sucess) &&
        (validateUsername() == InputStatus.sucess) &&
        (validatePassword() == InputStatus.sucess);
  }

  /// Returns the Status of the Email input field after check its validation
  ///
  /// the validation will be sucess when :
  ///      1- the email is correct
  /// the validator will return original if the field is empty
  /// otherwise the status will be faild and put an error message
  InputStatus validateEmail() {
    //Input : none
    //output: return the status of the Email input field

    if (inputEmailController.text.isEmpty)
      return InputStatus.original;
    else if (EmailValidator.validate(inputEmailController.text.toLowerCase()))
      return InputStatus.sucess;
    else {
      emailErrorMessage = 'Not a valid email address';
      return InputStatus.failed;
    }
  }

  /// check if the username is taken or not
  Future checkUnique() async {
    //Input : none
    //output: none
    final provider = Provider.of<Auth>(context, listen: false);
    provider.availableUserName(inputUserNameController.text).then((value) {
      isUnige = value;
    });
  }

  /// Returns the Status of the Username input field after check its validation
  ///
  /// the validation will be sucess when :
  ///      1- between 3-20 cahracters
  ///      2- the username is unique
  /// the validator will return original if the field is empty
  /// otherwise the status will be faild and put an error message
  InputStatus validateUsername() {
    //Input : none
    //output: return the status of the username input field
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

  /// Returns the Status of the Password input field after check its validation
  ///
  /// the validation will be sucess when there is at least 8 characters
  /// the validator will return original if the field is empty
  /// otherwise the status will be faild and put an error message
  InputStatus validatePassword() {
    //Input : none
    //output: return the status of the Password input field

    if (inputPasswardController.text.isEmpty)
      return InputStatus.original;
    else if (inputPasswardController.text.length >= 8)
      return InputStatus.sucess;
    else {
      passwordErrorMessage = 'the password must be at least 8 characters';
      return InputStatus.failed;
    }
  }

  /// Control the status of the Email textfield
  ///
  /// when user tap in the email textfailed mark it as taped
  /// when tap out check the validation using [validateEmail()]
  void controlEmailStatus(hasFocus) {
    //Input :
    // hasFocus:- Whether the Email input field is clikced or not
    //output : none
    if (hasFocus == true)
      inputEmailStatus = InputStatus.taped;
    else
      inputEmailStatus = validateEmail();
  }

  /// Control the status of the Username textfield
  ///
  /// Similar the [controlEmailStatus()] in the methodology
  void controlUsernameStatus(hasFocus) {
    //Input :
    // hasFocus:- Whether the UserName input field is clikced or not
    //output: none
    if (hasFocus)
      inputUsernameStatus = InputStatus.taped;
    else
      inputUsernameStatus = validateUsername();
  }

  /// Control the status of the Password textfield
  ///
  /// Similar the [controlEmailStatus()] in the methodology
  void controlPasswordStatus(hasFocus) {
    //Input :
    // hasFocus:- Whether the password input field is clikced or not
    //output: none

    if (hasFocus)
      inputPasswardStatus = InputStatus.taped;
    else
      inputPasswardStatus = validatePassword();
  }

  ///post the signup info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  void submitSignUp() async {
    //inpit : none
    //output: none

    final provider = Provider.of<Auth>(context, listen: false);
    await provider.sinUp({
      'userName': inputUserNameController.text,
      'email': inputEmailController.text,
      'password': inputPasswardController.text
    }).then((value) {
      //Navigator.of(context).pushNamed(Gender.routeName);
    });
    setState(() {
      isError = provider.error;
      errorMessage = provider.errorMessage;
      isSubmit = true;
      if (provider.error == false)
        Navigator.of(context).pushNamed(Gender.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (kIsWeb) WebImageLoging(),
          SizedBox(
            width: (kIsWeb) ? 25.w : null,
            child: Column(
              mainAxisAlignment:
                  (kIsWeb) ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!kIsWeb) UpperBar(UpperbarStatus.login),
                Expanded(
                  flex: (kIsWeb) ? 0 : 1,
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
                                width: (kIsWeb) ? 10.w : 20.h,
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black26,
                                ),
                              ),
                              Container(
                                child: Text(
                                    style: TextStyle(color: Colors.black),
                                    'OR'),
                              ),
                              Container(
                                width: (kIsWeb) ? 10.w : 20.h,
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
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
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
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
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
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
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
                                  color: (kIsWeb) ? Colors.blue : Colors.red),
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
                                style: TextStyle(color: Colors.black),
                                text: 'and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: (kIsWeb) ? Colors.blue : Colors.red),
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
                if (isSubmit && isError)
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          errorMessage,
                          style: TextStyle(
                            fontSize: 18,
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
                          color: Colors.green,
                        )),
                  ),
                if (kIsWeb) SizedBox(height: 5.h),
                Container(
                    height: (kIsWeb) ? 40 : null,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
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
                        // onPressed: () {},
                        onPressed: isFinished ? submitSignUp : null,
                        child: Text('Continue'),
                      ),
                    )),
                if (kIsWeb) SizedBox(height: 5.h),
                if (kIsWeb)
                  Row(
                    children: [
                      Text(
                        'alreday has account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Login.routeName);
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
