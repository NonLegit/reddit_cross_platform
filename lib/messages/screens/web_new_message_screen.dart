import 'package:flutter/material.dart';
import 'package:post/messages/widgets/first_nav_bar.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/message_provider.dart';
import 'web_message_screen.dart';
import 'web_sent_message.dart';

class WebNewMessageScreen extends StatefulWidget {
  WebNewMessageScreen({super.key});
  static const routeName = '/web-new-message-screen';
  //String? userName;
  @override
  State<WebNewMessageScreen> createState() => _WebNewMessageScreenState();
}

class _WebNewMessageScreenState extends State<WebNewMessageScreen> {
  String? sentUsername;
  String? toSendUsername;
  String? message;
  String? subject;
  bool userNameAvailable = false;
  bool subjectAvailable = false;
  bool messageAvailable = false;
  bool _iselected = false;
  //Parameters userName ==> whom to send to the message
  // subject ==> Message related to which topic
  // message ==> The main message you want to send
  _saveNewMessage(username, subject, message) {
    Provider.of<MessageProvider>(context, listen: false).createMessage(
        {'to': username, 'text': message, 'subject': subject},
        context).then((value) {
      Navigator.of(context).pushNamed(WebMessageScreen.routeName);
    });
  }

  //Function to get user name of logged in user
  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    sentUsername = 'u/${prefs.getString('userName') as String}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: FutureBuilder(
        future: getUserName(),
        builder: (context, snapshot) => (snapshot.connectionState ==
                ConnectionState.done)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FirstNavBar(),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Send a Private Message',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('from'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            enabled: false,
                            initialValue: sentUsername,
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.black54),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  bottom: 3, left: 5, top: 25, right: 5),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('to'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              toSendUsername = value;
                            },
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.black54),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  bottom: 3, left: 5, top: 25, right: 5),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Subject'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              subject = value;
                            },
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.black54),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  bottom: 3, left: 5, top: 25, right: 5),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Message'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 100,
                          child: TextFormField(
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              message = value;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 3, left: 5, top: 25, right: 5),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (toSendUsername!.isNotEmpty &&
                                subject!.isNotEmpty &&
                                message!.isNotEmpty) {
                              _saveNewMessage(toSendUsername, subject, message);
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Container(
                child: Text('Still loading'),
              ),
      ),
    );
  }
}
