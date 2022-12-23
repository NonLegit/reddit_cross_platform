import 'package:flutter/material.dart';
import 'package:post/messages/widgets/first_nav_bar.dart';
import 'package:post/messages/widgets/second_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../other_profile/screens/others_profile_screen.dart';
import '../../widgets/loading_reddit.dart';
import '../models/user_message.dart';
import '../provider/message_provider.dart';
import 'web_message_screen.dart';
import 'web_new_message_screen.dart';

class SentMessage extends StatefulWidget {
  const SentMessage({super.key});
  static const routeName = '/sent-message';

  @override
  State<SentMessage> createState() => _SentMessageState();
}

class _SentMessageState extends State<SentMessage> {
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

  bool _isInit = true;
  bool returned = false;
  bool tried = false;

  List<ShowMessagesModel> sentMessage = [];
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        returned = false;
      });
      //  _updateCount();
      await Provider.of<MessageProvider>(context, listen: false)
          .getSentMessages(context, 0, 10)
          .then((value) {
        sentMessage =
            Provider.of<MessageProvider>(context, listen: false).sentMessage;
        setState(() {
          returned = true;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: (!returned)
          ? const LoadingReddit()
          : (sentMessage.isEmpty)
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
                                            sentMessage[index].subjectText!,style: TextStyle(
                                              fontWeight: FontWeight.bold),),
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
                                                                arguments: sentMessage[index].toUsername
                                                      );
                                              },
                                              child: Text(
                                                'u/${sentMessage[index].toUsername!}',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                          Text(
                                              '   sent ${getTimeOfNotification(sentMessage[index].createdAt!)}'),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25,
                                            right: 8,
                                            bottom: 8,
                                            top: 8),
                                        child: Text(sentMessage[index].text!),
                                      ),
                                      if (sentMessage[index].type ==
                                          'subredditModeratorInvite')
                                        TextButton(
                                            onPressed: () {
                                              _acceptModeration(
                                                  sentMessage[index]
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
                                                      sentMessage[index].sId);
                                                },
                                                child: Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.grey))),
                                            TextButton(
                                                onPressed: () {
                                                  _blockUser(sentMessage[index]
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
                                itemCount: sentMessage.length,
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
