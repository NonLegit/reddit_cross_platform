import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:logins/logins/screens/gender.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import 'icons/redditIcons.dart';
import 'icons/GoogleFacebookIcons.dart';

import 'logins/screens/login.dart';
import 'logins/screens/signup.dart';
import 'logins/screens/forgot_password.dart';
import 'logins/screens/forgot_username.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'package:test/test.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Text('hello world'),
    //  );
    final forgot_sucess = '/users/forgot_password/204';
    final forgot_failed = '/users/forgot_password/400';
    final tempUrl = Uri.parse(
        'https://a6da66ef-18c0-4c77-bb40-45ec54bd706d.mock.pstmn.io' +
            forgot_failed);
    // http
    //     .post(tempUrl,
    //         body: json
    //             .encode({"email": "user@example.com", "userName": "string"}))
    //     .then((value) {
    //   print(value.statusCode);
    //   print(json.decode(value.body)['status']);
    //   print(json.decode(value.body)['errorMessage']);
    // });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

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
