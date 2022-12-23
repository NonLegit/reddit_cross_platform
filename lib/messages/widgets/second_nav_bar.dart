import 'package:flutter/material.dart';

import '../screens/web_message_all_screen.dart';
import '../screens/web_message_screen.dart';
import '../screens/web_new_message_screen.dart';
import '../screens/web_sent_message.dart';
import '../screens/unread_message_screen.dart';
class SecondNavBar extends StatelessWidget {
  const SecondNavBar({
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
                top: 10, bottom: 8, left: 100, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(AllMessageScreen.routeName);
                },
                child: Text('All')),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 10, bottom: 8, left: 8, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(UnreadMessageScreen.routeName);
                },
                child: Text('Unread')),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 8, left: 8, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(WebMessageScreen.routeName);
                },
                child: Text('Messages')),
          ),
        ],
      ),
    );
  }
}