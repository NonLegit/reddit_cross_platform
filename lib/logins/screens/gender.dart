import 'package:flutter/material.dart';
import '../models/status.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/upper_bar.dart';
import '../widgets/upper_text.dart';
import '../widgets/basic_buttom.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);
  static const routeName = '/Gender';
  final String url =
      'https://abf8b3a8-af00-46a9-ba71-d2c4eac785ce.mock.pstmn.io';

  /// variable to check if the backend finish the actual server of work with the mock
  final bool isMock = true;
  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  void submitGender(type) {
    print('object');
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
                      setState(() {
                        submitGender('Man');
                      });
                    },
                    lable: 'Man',
                  ),
                  BasicBottom(
                    handler: () {
                      setState(() {
                        submitGender('Woman');
                      });
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
