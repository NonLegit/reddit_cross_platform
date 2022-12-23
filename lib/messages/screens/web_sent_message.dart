import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'web_message_screen.dart';
import 'web_new_message_screen.dart';

class SentMessage extends StatefulWidget {
  const SentMessage({super.key});
  static const routeName = '/sent-message';

  @override
  State<SentMessage> createState() => _SentMessageState();
}

class _SentMessageState extends State<SentMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue.shade800,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 100, right: 20),
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
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 8, right: 20),
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
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 8, right: 20),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SentMessage.routeName);
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
              color: Colors.indigo[50],
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10),
              child: Container(
                color: Colors.indigo[50],
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ////subjectccccccccccccccccc
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Text('Jooko:'),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text('from  '),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Eman Shahda',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                                Text('   sent 3 days ago'),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 23, right: 8, bottom: 8, top: 8),
                              child: Text(
                                  'hiiiiiiiii bgfsvbhszdfkz hadsafjdnkd bhjknkamkfnk arhfbagjarehk dhfjskfa ajfbfrak dfjsk bfdjksml,;htgfjkdl;sp gfdjksl; mrtgwirjawelf gsduhskerjgesl sdgjhrkgl'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 8, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('Reply',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('Delete',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('BlockUser',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            )
                          ],
                        );
                      },
                      itemCount: 5,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
