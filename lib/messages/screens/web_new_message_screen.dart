import 'dart:html';

import 'package:flutter/material.dart';

import 'web_message_screen.dart';
import 'web_sent_message.dart';

class WebNewMessageScreen extends StatefulWidget {
  WebNewMessageScreen({super.key, this.userName});
  static const routeName = '/web-new-message-screen';
  String? userName;
  @override
  State<WebNewMessageScreen> createState() => _WebNewMessageScreenState();
}

class _WebNewMessageScreenState extends State<WebNewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue.shade800,
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WebNewMessageScreen.routeName);
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
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 8, right: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WebMessageScreen.routeName);
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
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 8, right: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SentMessage.routeName);
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
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Send a Private Message',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('from'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.userName,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      // print(value);
                      // username = value;
                      // _changeStateOfUserName();
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black54),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 3, left: 5, top: 25, right: 5),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('to'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    //  / enabled: (widget.userName != null) ? false : true,
                    //   initialValue:
                    //       (widget.userName != null) ? widget.userName : null,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      // print(value);
                      // username = value;
                      // _changeStateOfUserName();
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black54),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 3, left: 5, top: 25, right: 5),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Subject'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    //  / enabled: (widget.userName != null) ? false : true,
                    //   initialValue:
                    //       (widget.userName != null) ? widget.userName : null,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      // print(value);
                      // username = value;
                      // _changeStateOfUserName();
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black54),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 3, left: 5, top: 25, right: 5),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Message'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextFormField(
                      textInputAction: TextInputAction.newline,
                      // keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //  / enabled: (widget.userName != null) ? false : true,
                      //   initialValue:
                      //       (widget.userName != null) ? widget.userName : null,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        // print(value);
                        // username = value;
                        // _changeStateOfUserName();
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.black54),
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 3, left: 5, top: 25, right: 5),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
