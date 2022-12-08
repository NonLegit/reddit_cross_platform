import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../logins/models/status.dart';
import '../../models/wrapper.dart';
import '../widgets/setting_text_input.dart';
import '../widgets/setting_password_input.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangeEmail extends StatefulWidget {
  static const routeName = '/ChangeEmail';
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  String image =
      'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/31654_100661579985731_7481445_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGSUBKXvYU09Fg3jW1ZqDqRzHX4pfhTHOfMdfil-FMc57pdEjEJ1KtfYrGvqSbrlQffC8pXQZoBw7mz55jMjSUT&_nc_ohc=xPWf7TtIidQAX8W_Wb_&_nc_ht=scontent.fcai19-6.fna&oh=00_AfD1HpPtoFs3CoZZCgHcnaziqXK0c89So86U9HVRWVK5RQ&oe=63B85C99';
  String? userName = 'ahmed sayed';
  String? email = 'ahmedmadbouly@gmail.com';
  String? password = 'Aa123456*';

  /// listener to the Username input field
  final inputEmailController = TextEditingController();

  /// listener to the password input field
  final inputPasswardController = TextEditingController();

  ///Whether the password is visiable or not
  BoolWrapper isVisable = BoolWrapper();

  /// whether ther is an error or not
  bool isError = false;

  /// error message to view when action save is failed
  String errorMessg = '';

  /// the current status of the email input field
  InputStatus emailInput = InputStatus.original;

  ///the current status of the password input field
  InputStatus passwordInput = InputStatus.original;

  ///get the email and user name from server
  ///
  ///
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    // image=prefs.getString('image');
    print(image);
    // userName = prefs.getString('userNmae');
    // email = prefs.getString('email');
    // password = prefs.getString('password');
  }

  ///check if the input email is correct
  ///
  ///
  bool validMail() {
    if (inputEmailController.text.isEmpty) {
      isError = true;
      errorMessg = 'oops, you forgot your email';
      return false;
    } else if (EmailValidator.validate(
            inputEmailController.text.toLowerCase()) ==
        false) {
      isError = true;
      errorMessg = 'oops, fix your mail';
      return false;
    } else {
      isError = false;
      return true;
    }
  }

  ///check if the input password is correct
  ///
  ///
  bool validPassword() {
    if (inputPasswardController.text.isEmpty) {
      isError = true;
      errorMessg = 'oops, you forgot the password';
      return false;
    } else if (inputPasswardController.text != password) {
      isError = true;
      errorMessg = 'Wong passwod';
      return false;
    } else {
      return true;
    }
  }

  ///send the request to the backend and close the screen
  Future<void> changeEmail() async {}

  ///
  void saveChanges(context) {
    bool problem1 = false;
    bool problem2 = false;
    problem2 = validPassword();
    problem1 = validMail();
    if (problem1 == false || problem2 == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(isError: true, text: errorMessg, disableStatus: true),
      );
    } else {
      changeEmail();
    }
    ///////
  }

  ///change the status of email input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changeEmailFocus(focus) {
    emailInput = (focus) ? InputStatus.taped : InputStatus.original;
  }

  ///change the status of password input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changePasswordFocus(focus) {
    passwordInput = (focus) ? InputStatus.taped : InputStatus.original;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update email address')),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) => Column(
          children: [
            Expanded(
                child: Container(
                    child: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                    image,
                  )),
                  title: Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      'u/$userName'),
                  subtitle: Text('$email'),
                ),
                SettingTextInput(
                    lable: 'New email address',
                    ontap: (focus) {
                      changeEmailFocus(focus);
                      setState(() {});
                    },
                    changeInput: () {},
                    currentStatus: emailInput,
                    inputController: inputEmailController),
                SettingPasswordInput(
                    lable: 'Reddit password',
                    ontap: (focus) {
                      changePasswordFocus(focus);
                      setState(() {});
                    },
                    isVisable: isVisable,
                    currentStatus: passwordInput,
                    changeInput: () {},
                    inputController: inputPasswardController),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          insetPadding: EdgeInsets.all(10),
                          title: const Text('Forgot your password?'),
                          content: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SettingTextInput(
                                      lable: 'Username',
                                      currentStatus: InputStatus.original,
                                      ontap: (focus) {},
                                      changeInput: () {},
                                      inputController: TextEditingController()),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(0)),
                                      onPressed: () {
                                        print('object');
                                      },
                                      child: Text(
                                        'Forgot username',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 56, 93, 164)),
                                      ),
                                    ),
                                  ),
                                  SettingTextInput(
                                      lable: 'Email',
                                      currentStatus: InputStatus.original,
                                      ontap: (focus) {},
                                      changeInput: () {},
                                      inputController: TextEditingController()),
                                  Text(
                                      style: TextStyle(color: Colors.black54),
                                      'Unfortunately, if you have never given us your email, we will not able to reset your password'),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Having trouble? ',
                                            style:
                                                TextStyle(color: Colors.blue),
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
                                                  print(
                                                      "URL can't be launched.");
                                                }
                                              },
                                          ),
                                        )),
                                  ),
                                ]),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ).then((value) {
                        print(value);
                      }),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 56, 93, 164),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ]),
            ))),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 228, 231, 239),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: Text('Cancel'))),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          saveChanges(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 56, 93, 164),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: Text('Save')))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
