import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:post/messages/widgets/first_nav_bar.dart';
import 'package:post/messages/widgets/second_nav_bar.dart';
import 'package:post/other_profile/widgets/other_profile_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../messages/provider/message_provider.dart';
import '../../messages/screens/web_message_all_screen.dart';
import '../../messages/screens/web_sent_message.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../other_profile/screens/others_profile_screen.dart';
import '../../widgets/loading_reddit.dart';
import '../models/user_message.dart';
import 'web_new_message_screen.dart';

class WebMessageScreen extends StatefulWidget {
  const WebMessageScreen({super.key});
  static const routeName = 'web-message-screen';

  @override
  State<WebMessageScreen> createState() => _WebMessageScreenState();
}

class _WebMessageScreenState extends State<WebMessageScreen>
    with TickerProviderStateMixin {
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

  String me = '';

  bool _isInit = true;
  bool returned = false;
  bool tried = false;

  Map<String, List<ShowMessagesModel>> messageShow = {};
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        returned = false;
      });
        await Provider.of<MessageProvider>(context, listen: false)
            .getAllMessages(context, 0, 10)
            .then((value) {
          messageShow =
              Provider.of<MessageProvider>(context, listen: false).messageShow;
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
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(title: Text('Hiiiii')),
      body: (!returned)
          ? const LoadingReddit()
          : (messageShow.isEmpty)
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
                                  String key =
                                      messageShow.keys.elementAt(index);
                                  final message = messageShow[key]!.last;
                                  return Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            //ALways will be toUsername
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    padding: EdgeInsets.only(
                                                        left: 7, right: 7),
                                                    side: BorderSide(
                                                        color: Colors.black26),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                      Radius.circular(10),
                                                    )),
                                                  ),
                                                  //style: ,
                                                  onPressed: () {},
                                                  child: Text(
                                                    'u/${message.toUsername!}',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blue.shade300),
                                                  )),
                                            ),
                                            //subject of message
                                            Text(message.subjectText!),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: ListView.builder(
                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                            (messageShow[key]![
                                                                            index]
                                                                        .i ==
                                                                    0)
                                                                ? 'from  '
                                                                : 'to '),
                                                      ),
                                                      TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            padding:
                                                                EdgeInsets.zero,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(context).pushNamed(
                                                                OthersProfileScreen
                                                                    .routeName,
                                                                arguments: messageShow[
                                                                            key]![
                                                                        index]
                                                                    .fromUsername!);
                                                          },
                                                          child: Text(
                                                            'u/${messageShow[key]![index].fromUsername!}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          )),
                                                      Text(
                                                          '   sent ${getTimeOfNotification(messageShow[key]![index].createdAt!)}'),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        messageShow[key]![index]
                                                            .subjectText!),
                                                  ),
                                                  if (messageShow[key]![index]
                                                          .type ==
                                                      'subredditModeratorInvite')
                                                    TextButton(
                                                        onPressed: () {
                                                          _acceptModeration(
                                                              messageShow[key]![
                                                                      index]
                                                                  .subredditName);
                                                        },
                                                        child: Text(
                                                          'Click to accept',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                          ),
                                                        )),
                                                  Row(
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            _deleteMessage(
                                                                messageShow[key]![
                                                                        index]
                                                                    .sId);
                                                          },
                                                          child: Text('Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey))),
                                                      TextButton(
                                                          onPressed: () {
                                                            _blockUser(messageShow[
                                                                    key]![index]
                                                                .toUsername);
                                                          },
                                                          child: Text(
                                                              'BlockUser',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey))),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Colors.transparent,
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: messageShow[key]!.length,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: messageShow.length,
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
