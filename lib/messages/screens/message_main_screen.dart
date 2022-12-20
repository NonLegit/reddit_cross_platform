import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/messages/screens/show_message_body.dart';
import 'package:post/widgets/loading_reddit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Provider/message_provider.dart';
import '../models/user_message.dart';

class MessageMainScreen extends StatefulWidget {
  const MessageMainScreen({super.key});
  static const routeName = '/main-message-screen';

  @override
  State<MessageMainScreen> createState() => _MessageMainScreenState();
}

class _MessageMainScreenState extends State<MessageMainScreen> {
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

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  Map<String, List<ShowMessagesModel>> messageShow = {};
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        returned = false;
      });
      //  _updateCount();
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

  String getUsername(me, to, from) {
    return (me == to) ? from : to;
  }

  _blockUser(userName) {
    Provider.of<MessageProvider>(context, listen: false)
        .blockUser(context, userName);
  }
  
  

  _onclick(index) {
    // int id;
    final get = messageShow[index]!.firstWhere((element) {
      return element.fromUsername != element.me;
      // element.toUsername != element.me;
    });
    if(get !=null){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowMessageBody(
            list: messageShow[index],
            appBarText: getUsername(
                messageShow[index]![0].me,
                messageShow[index]![0].toUsername,
                messageShow[index]![0].fromUsername),
            messageId: get.sId,
          ),
        ));
  }
  }

  @override
  Widget build(BuildContext context) {
    return (!returned)
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
            : Container(
                color: Colors.white,
                child: Expanded(
                  child: SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String key = messageShow.keys.elementAt(index);
                            print(key);
                            final message = messageShow[key]!.last;
                            print(message.subjectText);
                            print(message.text);
                            return GestureDetector(
                              onTap: () {
                                _onclick(key);
                                // Navigator.of(context)
                                //     .pushNamed(ShowMessageBody.routeName);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Icon(Icons.email,
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          message.subjectText!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      Spacer(),
                                      PopupMenuButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(
                                            maxHeight: 11.h, maxWidth: 40.w),
                                        position: PopupMenuPosition.under,
                                        elevation: 2,
                                        onSelected: (value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                'Block ${getUsername(message.me, message.toUsername, message.fromUsername)}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              insetPadding: EdgeInsets.zero,
                                              content: SizedBox(
                                                width: 40.h,
                                                child: const Text(
                                                  'They won\'t be able to contact you or view your\nprofile,posts,or comments',
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              actions: [
                                                SizedBox(
                                                  width: 20.h,
                                                  height: 5.h,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      primary: Colors.grey[200],
                                                      // backgroundColor: Colors.grey[200],
                                                    ),
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.h,
                                                  height: 5.h,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      _blockUser(getUsername(
                                                          message.me,
                                                          message.toUsername,
                                                          message
                                                              .fromUsername));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      primary: Colors.red,
                                                      // backgroundColor: Colors.blue[800],
                                                    ),
                                                    child: const Text(
                                                      'Block acount',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(children: const [
                                              Icon(
                                                Icons.person_off,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Block account',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 45),
                                    child: Text(
                                      message.text!,
                                      // 'hi fdsghjgf tryu sdafrfty zdfgh sdfghh werty werty ewrt6ytre aew ghfgskgks wertyu wertyu 34567 waesrdty asdfgthy ewret',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 45, top: 10),
                                    child: RichText(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        //softWrap: true,
                                        text: TextSpan(
                                            text: '${message.toUsername}   ',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                            children: [
                                              const WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.grey,
                                                  size: 4,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: getTimeOfNotification(
                                                      message.createdAt
                                                          .toString()),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10))
                                            ])

                                        //overflow: TextOverflow.clip,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: messageShow.length,
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}
