import 'package:flutter/material.dart';
import 'package:post/logins/screens/forgot_username.dart';
import 'package:provider/provider.dart';
import '../widgets/text_input.dart';
import '../widgets/upper_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/upper_text.dart';
import 'forgot_password.dart';
import '../widgets/password_input.dart';
import '../widgets/continue_with_facebook.dart';
import '../widgets/continue_with_google.dart';
import '../../models/wrapper.dart';
import '../../home/screens/home_layout.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../providers/authentication.dart';
import '../api/google_sign_in.dart';
import '../../moderation_settings/widgets/status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup.dart';
import '../widgets/web_image.dart';

class Login extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/Login';

  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool fetchingDone = true;
  bool _isInit = true;
  bool _isBuild = false;

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
  bool isError = true;

  /// Whether the user tring to submit or not
  bool isSubmit = false;

  /// error message to view when the log in is failed
  String errorMessage = '';

  ///post the login info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  /// if the server return failed response then there is error message will appare
  /// other wise jump on the homeScreen

  void checkLogin(context) async {
    //Input :
    //  context:- the Build context of the current screen
    //output: none

    final provider = Provider.of<Auth>(context, listen: false);
    provider.login({
      'userName': inputUserNameController.text,
      'password': inputPasswardController.text
    }).then((value) {
      isError = provider.error;
      isSubmit = true;
      errorMessage = provider.errorMessage;
      if (!isError) {
        Navigator.of(context).pushNamed(HomeLayoutScreen.routeName);
      }
      setState(() {});
    });
  }

  ///check if the user is already Authenticated
  ///
  ///if the user is authenticated , then send him to the home page
  ///other wise continue to the login
  Future<bool> checkAut(context) async {
    //Input :
    //  context:- the Build context of the current screen
    //output: return bool Whether the user is authorised or not

    String isLog = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as String
        : '';
    if (isLog == null || isLog != 'logout') {
      final provider = Provider.of<Auth>(context, listen: false);
      await provider.alreadyAuth();
      if (provider.alreadyAuthed) {
        Navigator.of(context).pushReplacementNamed(HomeLayoutScreen.routeName);
      }

      return provider.alreadyAuthed;
    }
    return false;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      checkAut(context).then((value) {
        fetchingDone = true;
        if (_isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isBuild = true;
    kIsWeb;
    final mediaQuery = MediaQuery.of(context);
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
                if (!kIsWeb) UpperBar(UpperbarStatus.signup),
                Expanded(
                  flex: (kIsWeb) ? 0 : 1,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      UpperText('Log in to Reddit'),
                      SizedBox(
                        height: 4.h,
                      ),
                      ContinueWithGoogle(handler: () async {
                        final user = await GoogleSignInApi.login();
                        user!.id;
                        final provider =
                            Provider.of<Auth>(context, listen: false);
                        await provider.GoogleAuth({
                          "id": user.id,
                          "email": user.email,
                          "displayName": user.displayName!
                        });
                        if (provider.error == false) {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeLayoutScreen.routeName);
                        }
                      }),
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
                                  style: TextStyle(color: Colors.black), 'OR'),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ResponsiveSizer(
                                              builder: (cntx, orientation,
                                                  Screentype) {
                                                // Device.deviceType == DeviceType.web;
                                                return Scaffold(
                                                    body: ForgotPassword());
                                              },
                                            ),
                                          ));
                                    },
                                    child: Text(
                                        style: TextStyle(
                                            color: (kIsWeb)
                                                ? Colors.blue
                                                : Colors.red),
                                        'Forget passward'))),
                            if (kIsWeb)
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ResponsiveSizer(
                                                builder: (cntx, orientation,
                                                    Screentype) {
                                                  // Device.deviceType == DeviceType.web;
                                                  return Scaffold(
                                                      body: ForgotUserName());
                                                },
                                              ),
                                            ));
                                      },
                                      child: Text(
                                          style: TextStyle(
                                              color: (kIsWeb)
                                                  ? Colors.blue
                                                  : Colors.red),
                                          'Forget Username'))),
                          ],
                        ),
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
                        onPressed: isFinished
                            ? () {
                                checkLogin(context);
                              }
                            : null,
                        child: (kIsWeb) ? Text('Log in') : Text('Continue'),
                      ),
                    )),
                if (kIsWeb) SizedBox(height: 5.h),
                if (kIsWeb)
                  Row(
                    children: [
                      Text(
                        'New to Reddit? ',
                        style: TextStyle(color: Colors.black),
                      ),
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
    );
  }
}
