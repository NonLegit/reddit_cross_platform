import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../moderation_settings/widgets/status.dart';
import '../../models/wrapper.dart';
import '../widgets/setting_text_input.dart';
import '../widgets/setting_password_input.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import '../provider/user_settings_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/ChangePassword';
  final UserSettingsProvider? provider;

  ChangePassword({Key? key, this.provider}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? image =
      'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2';
  String? userName = 'ahmed sayed';
  String? password = 'Aa123456*';

  /// listener to the Current password input field
  final inputCurrentPasswordController = TextEditingController();

  /// listener to the New password input field
  final inputNewPasswordController = TextEditingController();

  /// listener to the Confirm New password input field
  final inputConfirmNewPasswordController = TextEditingController();

  ///Whether the password is visiable or not
  BoolWrapper isVisable1 = BoolWrapper();

  ///Whether the password is visiable or not
  BoolWrapper isVisable2 = BoolWrapper();

  ///Whether the password is visiable or not
  BoolWrapper isVisable3 = BoolWrapper();

  /// whether ther is an error or not
  bool isError = false;

  /// error message to view when action save is failed
  String errorMessg = '';

  /// the current status of the Current password input field
  InputStatus CurrentpasswordInput = InputStatus.original;

  ///the current status of the New password input field
  InputStatus NewpasswordInput = InputStatus.original;

  ///the current status of the Confirm New password input field
  InputStatus ConfirmNewpasswordInput = InputStatus.original;

  ///get the email and user name from server
  ///
  ///

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    // image = prefs.getString('image');
    userName = prefs.getString('userName');
    // password = prefs.getString('password');
  }

  ///change the status of Current password input field
  ///
  ///make it taped or orignal according to the focus listner
  void changeCurrentpasswordFocus(focus) {
    CurrentpasswordInput = (focus) ? InputStatus.taped : InputStatus.original;
  }

  ///change the status of New password input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changeNewpasswordFocus(focus) {
    NewpasswordInput = (focus) ? InputStatus.taped : InputStatus.original;
  }

  ///change the status of Confirm New password input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changeConfirmNewpasswordFocus(focus) {
    ConfirmNewpasswordInput =
        (focus) ? InputStatus.taped : InputStatus.original;
  }

  ///check if the input password is correct
  ///
  ///
  bool validPassword() {
    if (inputCurrentPasswordController.text.isEmpty) {
      isError = true;
      errorMessg = 'oops, you forgot the password';
      return false;
    } else if (inputCurrentPasswordController.text != password) {
      isError = true;
      errorMessg = 'wrong password.';
      return false;
    } else {
      return true;
    }
  }

  ///check if the input password is correct
  ///
  ///
  bool validNewPassword() {
    if (inputNewPasswordController.text.isEmpty) {
      isError = true;
      errorMessg = 'oops, you forgot the New password';
      return false;
    } else if (inputNewPasswordController.text.length < 8) {
      errorMessg =
          'Sorry, your password must be at least 8 characters long. Try that again.';
      return false;
    } else {
      return true;
    }
  }

  ///check if the input password is correct
  ///
  ///
  bool validConfirmNewPassword() {
    if (inputConfirmNewPasswordController.text.isEmpty) {
      isError = true;
      errorMessg = 'oops, you forgot Confirm the New password';
      return false;
    } else if (inputConfirmNewPasswordController.text !=
        inputNewPasswordController.text) {
      errorMessg = 'Oops, your passwords don\'t match, Try that again.';
      return false;
    } else if (inputConfirmNewPasswordController.text.length < 8) {
      errorMessg =
          'Sorry, your password must be at least 8 characters long. Try that again.';
      return false;
    } else {
      return true;
    }
  }

  ///send the request to the backend and close the screen
  Future<void> ChangePassword() async {
    await widget.provider!.changePassword({
      "oldPassword": inputCurrentPasswordController.text,
      "newPassword": inputNewPasswordController.text,
      "confirmNewPassword": inputConfirmNewPasswordController.text,
      "keepLoggedIn": true
    }, context).then((value) {
      if (widget.provider?.isError == false) {
        print('suce');
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
              isError: false,
              text: 'your password changed succefuly',
              disableStatus: true),
        );
        setState(() {
          // widget.provider!.userPrefrence?. = inputEmailController.text;
          // email = widget.provider!.userPrefrence?.email;
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   CustomSnackBar(isError: true, text: 'error', disableStatus: true),
        // );
      }
    });
  }

  ///
  void saveChanges(context) {
    bool problem1 = false;
    bool problem2 = false;
    bool problem3 = false;
    problem3 = validConfirmNewPassword();
    problem2 = validNewPassword();
    problem1 = validPassword();
    if (problem1 == false || problem2 == false || problem3 == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          isError: true,
          text: errorMessg,
          disableStatus: true,
        ),
      );
    } else {
      ChangePassword();
    }
    ///////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change password')),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) => Column(children: [
          Expanded(
              child: Container(
                  child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                    image as String,
                  )),
                  title: Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      'u/$userName'),
                ),
                SettingPasswordInput(
                    lable: 'Current password',
                    ontap: (focus) {
                      changeCurrentpasswordFocus(focus);
                      setState(() {});
                    },
                    isVisable: isVisable1,
                    currentStatus: CurrentpasswordInput,
                    changeInput: () {},
                    inputController: inputCurrentPasswordController),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
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
                SettingPasswordInput(
                    lable: 'New password',
                    ontap: (focus) {
                      changeNewpasswordFocus(focus);
                      setState(() {});
                    },
                    isVisable: isVisable2,
                    currentStatus: NewpasswordInput,
                    changeInput: () {},
                    inputController: inputNewPasswordController),
                SettingPasswordInput(
                    lable: ' Confirm New password',
                    ontap: (focus) {
                      changeConfirmNewpasswordFocus(focus);
                      setState(() {});
                    },
                    isVisable: isVisable3,
                    currentStatus: ConfirmNewpasswordInput,
                    changeInput: () {},
                    inputController: inputConfirmNewPasswordController),
              ],
            ),
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
        ]),
      ),
    );
  }
}
