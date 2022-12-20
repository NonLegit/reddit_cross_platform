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

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);
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
    isFinished = (validateEmail() == InputStatus.sucess) &
        (validateUsername() == InputStatus.sucess) &
        (validatePassword() == InputStatus.sucess);
  }

  /// Returns the Status of the Email input field after check its validation
  ///
  /// the validation will be sucess when :
  ///      1- the email is correct
  /// the validator will return original if the field is empty
  /// otherwise the status will be faild and put an error message
  InputStatus validateEmail() {
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
    if (hasFocus == true)
      inputEmailStatus = InputStatus.taped;
    else
      inputEmailStatus = validateEmail();
  }

  /// Control the status of the Username textfield
  ///
  /// Similar the [controlEmailStatus()] in the methodology
  void controlUsernameStatus(hasFocus) {
    if (hasFocus)
      inputUsernameStatus = InputStatus.taped;
    else
      inputUsernameStatus = validateUsername();
  }

  /// Control the status of the Password textfield
  ///
  /// Similar the [controlEmailStatus()] in the methodology
  void controlPasswordStatus(hasFocus) {
    if (hasFocus)
      inputPasswardStatus = InputStatus.taped;
    else
      inputPasswardStatus = validatePassword();
  }

  ///post the signup info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  void submitSignUp() async {
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
