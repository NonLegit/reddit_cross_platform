import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebMessageScreen extends StatefulWidget {
  const WebMessageScreen({super.key});
  static const routeName = 'web-message-screen';

  @override
  State<WebMessageScreen> createState() => _WebMessageScreenState();
}

class _WebMessageScreenState extends State<WebMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue.shade700,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Send a Private Message',
                        style: TextStyle(color: Colors.grey.shade400,fontSize: 15),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Inbox',
                        style: TextStyle(color: Colors.grey.shade400,fontSize: 15),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.grey.shade400,fontSize: 15),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
