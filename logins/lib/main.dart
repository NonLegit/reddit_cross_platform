import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import 'icons/redditIcons.dart';
import 'icons/GoogleFacebookIcons.dart';

import 'logins/login.dart';
import 'logins/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Text('hello world'),
    // );
    return ResponsiveSizer(
      builder: (cntx, orientation, Screentype) {
        Device.deviceType == DeviceType.web;
        return MaterialApp(
            title: 'Logins',
            theme: ThemeData(
              primarySwatch: Colors.red,
              backgroundColor: Color.fromARGB(26, 82, 82, 82),
              // primaryColor: Colors.red,
            ),
            home: SignUp());
      },
    );
  }
}
