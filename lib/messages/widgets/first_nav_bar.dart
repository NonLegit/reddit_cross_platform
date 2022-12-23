import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/web_message_screen.dart';
import '../screens/web_new_message_screen.dart';
import '../screens/web_sent_message.dart';
class FirstNavBar extends StatelessWidget {
  FirstNavBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade800,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 13, bottom: 13, left: 100, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(WebNewMessageScreen.routeName);
                },
                child: Text(
                  'Send a Private Message',
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 13, bottom: 13, left: 8, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(WebMessageScreen.routeName);
                },
                child: Text(
                  'Inbox',
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 13, bottom: 13, left: 8, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(SentMessage.routeName);
                },
                child: Text(
                  'Sent',
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}