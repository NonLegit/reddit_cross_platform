import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../other_profile/screens/others_profile_screen.dart';
import '../../widgets/loading_reddit.dart';
import '../models/user_message.dart';
import '../provider/message_provider.dart';
import '../widgets/first_nav_bar.dart';
import '../widgets/second_nav_bar.dart';
import 'web_message_all_screen.dart';
import 'web_message_screen.dart';
import 'web_new_message_screen.dart';
import 'web_sent_message.dart';

class UnreadMessageScreen extends StatefulWidget {
  const UnreadMessageScreen({super.key});
  static const routeName = '/unread-message-screen';

  @override
  State<UnreadMessageScreen> createState() => _UnreadMessageScreenState();
}

class _UnreadMessageScreenState extends State<UnreadMessageScreen> {
  bool _isInit = true;
  bool returned = false;
  bool tried = false;

  List<ShowMessagesModel> unreadMessage = [];
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        returned = false;
      });
      await Provider.of<MessageProvider>(context, listen: false)
          .getUnreadMessages(context, 0, 10)
          .then((value) async {
        unreadMessage =
            Provider.of<MessageProvider>(context, listen: false).unreadMessage;
        await Provider.of<MessageProvider>(context, listen: false)
            .markAllAsRead(context);
        setState(() {
          returned = true;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }
  //deleteMessage => parameter take id of required messaged to be deleted
  _deleteMessage(id) async {
    await Provider.of<MessageProvider>(context, listen: false)
        .deleteMessage(context, id);
  }
  //blockUser => parameter take username of required user to be blocked
  _blockUser(userName) async {
    await Provider.of<MessageProvider>(context, listen: false)
        .blockUser(context, userName);
  }
  //Parse String to Date Time and get actual time
  //Input String 
  //Return type string
  String getTimeOfNotification(date) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(date));
    if (difference.inDays >= 365) {
      howOld = '${difference.inDays ~/ 365}y';
    } else if (difference.inDays >= 30) {
      howOld = '${difference.inDays ~/ 30}mo';
    } else if (difference.inDays >= 1) {
      howOld = '${difference.inDays}d';
    } else if (difference.inMinutes >= 60) {
      howOld = '${difference.inHours}h';
    } else if (difference.inSeconds >= 60) {
      howOld = '${difference.inMinutes}m';
    } else {
      howOld = '${difference.inSeconds}s';
    }
    return howOld;
  }
  //Called when user accepts to be moderator in the subreddit
  //Parameter subreddit name that user will accept invitation in
  _acceptModeration(subredditName) {
    Provider.of<MessageProvider>(context, listen: false)
        .acceptSubredditInvite(context, subredditName)
        .then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: (!returned)
          ? LoadingReddit()
          : (unreadMessage.isEmpty)
              ? Container(
                  color: Colors.grey[100],
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/emptyNotification.png'),
                      Text(
                        'Wow,such empty',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  )),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FirstNavBar(),
                      SecondNavBar(),
                      Container(
                        color: Colors.indigo[50],
                        margin:
                            EdgeInsets.only(left: 10.w, right: 10.w, top: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ////subjectccccccccccccccccc
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: Text(
                                          unreadMessage[index].subjectText!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 18),
                                            child: Text('from  '),
                                          ),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    OthersProfileScreen
                                                        .routeName,
                                                    arguments:
                                                        unreadMessage[index]
                                                            .toUsername);
                                              },
                                              child: Text(
                                                'u/${unreadMessage[index].fromUsername!}',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                          Text(
                                              '   sent ${getTimeOfNotification(unreadMessage[index].createdAt!)}'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25,
                                            right: 8,
                                            bottom: 8,
                                            top: 8),
                                        child: Text(unreadMessage[index].text!),
                                      ),
                                      if (unreadMessage[index].type ==
                                          'subredditModeratorInvite')
                                        TextButton(
                                            onPressed: () {
                                              _acceptModeration(
                                                  unreadMessage[index]
                                                      .subredditName);
                                            },
                                            child: Text(
                                              'Click to accept',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 19,
                                            right: 8,
                                            bottom: 8,
                                            top: 8),
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  _deleteMessage(
                                                      unreadMessage[index].sId);
                                                },
                                                child: Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.grey))),
                                            TextButton(
                                                onPressed: () {
                                                  _blockUser(
                                                      unreadMessage[index]
                                                          .toUsername);
                                                },
                                                child: Text('BlockUser',
                                                    style: TextStyle(
                                                        color: Colors.grey))),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  );
                                },
                                itemCount: unreadMessage.length,
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
