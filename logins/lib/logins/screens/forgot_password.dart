import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets/upper_bar.dart';
import '../widgets/text_input.dart';
import '../widgets/upper_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'forgot_username.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // const ForgotPassword({Key? key}) : super(key: key);
  TextEditingController inputUserNameController = TextEditingController();

  bool isFinished = false;

  TextEditingController inputEmailController = TextEditingController();

  void changeInput() {
    setState(() {
      isFinished = (!inputUserNameController.text.isEmpty) &
          (!inputEmailController.text.isEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpperBar('log'),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UpperText('Forgot your password?'),
                  SizedBox(height: 4.h),
                  TextInput(
                    changeInput: changeInput,
                    ontap: () {},
                    inputController: inputUserNameController,
                    lable: 'Username',
                  ),
                  TextInput(
                    changeInput: changeInput,
                    ontap: () {},
                    inputController: inputEmailController,
                    lable: 'Email',
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        style: TextStyle(color: Colors.black54),
                        'Unfortunately, if you have never given us your email, we will not able to reset your password'),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResponsiveSizer(
                                    builder: (cntx, orientation, Screentype) {
                                      // Device.deviceType == DeviceType.web;
                                      return Scaffold(
                                        body: ForgotUserName(),
                                      );
                                    },
                                  ),
                                ));
                          },
                          child: Text('Forget Username?'))),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Having trouble? ',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
          Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: isFinished ? () {} : null,
                  child: Text('Continue'),
                ),
              ))
        ],
      ),
    );
  }
}
