import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/status.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/upper_bar.dart';
import '../widgets/upper_text.dart';
import '../widgets/basic_buttom.dart';
import '../../home/screens/home_layout.dart';
import 'package:http/http.dart' as http;
import '../providers/authentication.dart';

class Gender extends StatefulWidget {
  // const Gender({Key? key}) : super(key: key);
  static const routeName = '/Gender';

  @override
  State<Gender> createState() => GenderState();
}

class GenderState extends State<Gender> {
  /// submit the gender th the database and got to home
  void submitGender(type, context) async {
    final provider = Provider.of<Auth>(context, listen: false);
    provider.changeGender(type).then((value) {
      if (value) Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperBar(UpperbarStatus.skip),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UpperText('About you'),
                  Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                        'tell us about yourself to start building your home feed'),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                        'I\'m a ...'),
                  ),
                  BasicBottom(
                    handler: () {
                      submitGender('Man', context);
                      // });
                    },
                    lable: 'Man',
                  ),
                  BasicBottom(
                    handler: () {
                      // setState(() {
                      submitGender('Woman', context);
                      // });
                    },
                    lable: 'Woman',
                  ),
                ]),
          ))
        ],
      ),
    );
  }
}
